import 'package:flutter/material.dart';
import 'package:news/themes/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sera ya Faragha', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sera ya Faragha',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Imesasishwa mwisho: Julai 25, 2024',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Utangulizi',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Karibu kwenye Mange, programu ya habari iliyoundwa kukupa habari za hivi punde kutoka ulimwenguni kote. Tunathamini faragha yako na tumejitolea kulinda taarifa zako za kibinafsi. Sera hii ya Faragha inaeleza jinsi tunavyokusanya, kutumia, na kulinda data yako.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Taarifa Tunazokusanya',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '1. Taarifa za Kibinafsi: Tunapokusajili kwa akaunti, tunakusanya taarifa za kibinafsi kama jina lako, barua pepe, na maelezo ya mawasiliano.\n'
                '2. Data ya Matumizi: Tunakusanya taarifa kuhusu jinsi unavyotumia programu yetu, ikijumuisha tabia zako za kusoma, muda unaotumia kwenye skrini mbalimbali, na makala unayosoma.\n'
                '3. Taarifa za Kifaa: Tunaweza kukusanya taarifa kuhusu kifaa chako, ikijumuisha mfano, mfumo wa uendeshaji, na vitambulisho vya kipekee vya kifaa.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Jinsi Tunavyotumia Taarifa Zako',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '1. Kutoa na Kuboresha Huduma Zetu: Tunatumia taarifa zako kuwasilisha makala ya habari unayotaka na kuboresha utendaji wa programu yetu.\n'
                '2. Kuwasiliana na Wewe: Tunaweza kutumia taarifa zako kukutumia masasisho, majarida, na maudhui ya matangazo ambayo yanaweza kukuvutia.\n'
                '3. Kubinafsisha Uzoefu Wako: Tunatumia data yako kubadilisha maudhui na matangazo tunayokuonyesha ili yaendane na maslahi yako.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Usalama wa Data',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Tunachukua hatua za kiusalama zinazofaa kulinda taarifa zako za kibinafsi dhidi ya ufikiaji usioidhinishwa, ufichuzi, mabadiliko, au uharibifu. Hata hivyo, hakuna njia ya usafirishaji juu ya mtandao au njia ya kuhifadhi elektroniki iliyo salama kwa asilimia 100.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Haki Zako za Faragha',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Una haki ya kufikia, kusasisha, au kufuta taarifa za kibinafsi tunazoshikilia kukuhusu. Pia unaweza kujiondoa kupokea mawasiliano ya matangazo kutoka kwetu wakati wowote.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Mabadiliko ya Sera Hii ya Faragha',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Tunaweza kusasisha Sera yetu ya Faragha mara kwa mara. Tutakujulisha kuhusu mabadiliko yoyote kwa kuchapisha sera mpya kwenye ukurasa huu.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),

            ],
          ),
        ),
      ),
    );
  }
}
