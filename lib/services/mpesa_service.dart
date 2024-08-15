import 'dart:convert';
import 'package:http/http.dart' as http;

class MPesaService {
  final String consumerKey = '0U6skxGaWiAUbOxuV6TDYWEiBWWV0dGxrbN7TESJW28aEA0z';
  final String consumerSecret = 'VkL3IGdSzKmeAR5ji5oV3KlyUzXlZ9b15ssHedbntR6uxhGKMVqh7NxEotdCfCkA';
  final String shortCode = '174379';
  final String lipaNaMpesaOnlinePassKey = 'your_passkey';
  final String baseUrl = 'https://sandbox.safaricom.co.ke';

  Future<String> getAccessToken() async {
    final response = await http.get(
      Uri.parse('$baseUrl/oauth/v1/generate?grant_type=client_credentials'),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret')),
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<void> lipaNaMpesa(String phoneNumber, double amount) async {
    final String accessToken = await getAccessToken();
    final String timestamp = DateTime.now().toUtc().toString().replaceAll(RegExp(r'\D'), '').substring(0, 14);
    final String password = base64Encode(utf8.encode('$shortCode$lipaNaMpesaOnlinePassKey$timestamp'));

    final response = await http.post(
      Uri.parse('$baseUrl/mpesa/stkpush/v1/processrequest'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'BusinessShortCode': shortCode,
        'Password': password,
        'Timestamp': timestamp,
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': amount,
        'PartyA': phoneNumber,
        'PartyB': shortCode,
        'PhoneNumber': phoneNumber,
        'CallBackURL': 'https://mydomain.com/pat',
        'AccountReference': 'account_reference',
        'TransactionDesc': 'Payment for subscription',
      }),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print('Response: $body');
    } else {
      throw Exception('Failed to initiate payment');
    }
  }
}
