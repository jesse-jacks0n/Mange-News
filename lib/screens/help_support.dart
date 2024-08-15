import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/colors.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Msaada na Usaidizi',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Je una habari yeyote? na ungetaka kutuletea, tafadhali tujulishe',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: _buildContactRow(
                  FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 24),
                  'Whatsapp: +254788901914',
                  '+254788901914',
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Kama hutaki kujulikana kabisa, basi tuletee habari kupitia:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    _buildContactRow(
                      FaIcon(FontAwesomeIcons.telegram, color: Colors.blue, size: 24),
                      'Telegram: @mangekimambiisupport',
                      '@mangekimambiisupport',
                    ),
                    const SizedBox(height: 16),
                    _buildContactRow(
                      FaIcon(FontAwesomeIcons.solidEnvelope, color: Colors.red, size: 24),
                      'Email: mangekimambiiapp.africa@gmail.com',
                      'mangekimambiiapp.africa@gmail.com',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              const Text(
                'Kama una tatizo la kiufundi au tatizo la malipo au tatizo katika kujisajili, wasiliana nasi kupitia:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    _buildContactRow(
                      FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 24),
                      'Whatsapp: +254788901914',
                      '+254788901914',
                    ),
                    const SizedBox(height: 16),
                    _buildContactRow(
                      FaIcon(FontAwesomeIcons.telegram, color: Colors.blue, size: 24),
                      'Telegram: +254745900962',
                      '+254745900962',
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(Widget icon, String text, String clipboardText) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, color: Colors.grey),
          onPressed: () => _copyToClipboard(clipboardText),
        ),
      ],
    );
  }
}
