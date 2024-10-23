import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: black,
        centerTitle: true,
        title: const Text('About Us'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              'Welcome to Klik!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: green
              ),
            ),
              kheight,
            
             Text(
              'In an era where connectivity is crucial, Klik is designed to enhance social interaction with vibrancy, personalization, and ease. Powered by Flutter, our app aims to unite individuals, strengthen bonds, and cultivate communities through effortless communication and engaging features.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight,
           
             Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
             Text(
              '''At Klik, we're dedicated to fostering authentic connections. Our goal is to build a space where you can express yourself, share your experiences, and engage with people who share your interests. Whether reconnecting with old friends or forging new relationships, Klik is designed to make your social experience vibrant and enjoyable.''',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
             Text(
              'What We Offer',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, 
                children: [
                  Baseline(
                    baseline: 20, 
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Dynamic Social Interaction: Connect with friends and communities effortlessly through our user-friendly and feature-packed interface.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, 
                children: [
                  Baseline(
                    baseline: 20,
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Real-time Communication: Experience smooth chatting, photo sharing, and more, all in real-time.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, 
                children: [
                  Baseline(
                    baseline: 20,
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Personalized Experience: Customize your Klik experience with adjustable profiles, themes, and content preferences.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, 
                children: [
                  Baseline(
                    baseline: 20, 
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Secure and Private: We prioritize your data security with strong privacy settings and protection measures to keep your information safe.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, 
                children: [
                  Baseline(
                    baseline: 20, 
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Community Building: Create or join groups and communities that align with your interests and passions.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight20,
           
             Text(
              'Why Choose Klik?',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
            Text('''Klik transcends typical social media apps; it's crafted to elevate your connectivity experience. Leveraging cutting-edge Flutter technology, our app ensures a seamless and dynamic user experience. We continuously innovate, introducing fresh features and enhancements to make your social interactions more engaging and enjoyable.''',style: TextStyle(fontSize: 16.0),),
             kheight20,
            
             Text(
              'Our Journey',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
            Text('''Klik was created by a dedicated team of developers and social media enthusiasts with a vision to revolutionize the digital social experience. Recognizing the need for a platform that fosters genuine connections and enhances users' lives, we embarked on this journey inspired by your stories, relationships, and experiences.''',style: TextStyle(fontSize: 16.0),),
            kheight20,
            // Join Us
             Text(
              'Join Us',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
             Text(
'Join the Klik community today! Download our app and dive into a vibrant world where your social experiences are full of excitement and endless opportunities.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
             SizedBox(height: 10.0),
             Text(
              ''''We're eager to hear from you! For any questions, feedback, or suggestions, don't hesitate to get in touch with us at''',
              style: TextStyle(fontSize: 16.0),
            ),
            ],
          ),
        ),
      )
    );
    
  }
}