import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/colors.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Kuhusu',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kuhusu Mangekimambii App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Mangekimambii App ni jukwaa la habari linalokusudia kutoa taarifa sahihi na za kuaminika kuhusu matukio, maendeleo, na shughuli za kijamii. Tunajitahidi kutoa taarifa za hivi karibuni na muhimu kwa jamii yetu, ili kila mmoja aweze kufahamu na kushiriki katika masuala muhimu.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'Malengo Yetu',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '1. Kutoa habari za kuaminika na sahihi kwa wakati.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '2. Kuwezesha watumiaji kupata taarifa muhimu kuhusu matukio na maendeleo ya kijamii.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '3. Kuimarisha ushirikiano na jamii kwa kutoa jukwaa la wazi la mawasiliano.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'Timu Yetu',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Tuna timu ya wataalamu wa habari na teknolojia wanaojitolea kutoa huduma bora kwa watumiaji wetu. Kila mmoja wetu ana uzoefu wa kipekee na tunafanya kazi kwa karibu ili kuhakikisha kuwa tunakidhi mahitaji ya watumiaji wetu.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'Wasiliana Nasi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.red, size: 24),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Email: mangekimambiiapp.africa@gmail.com',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 24),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Whatsapp: +254788901914',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.telegram, color: Colors.blue, size: 24),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Telegram: @mangekimambiisupport',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Tunathamini maoni yako na tunatarajia kujua zaidi kutoka kwako ili kuboresha huduma zetu.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
