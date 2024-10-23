
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';

class PrivacyPoliciesPage extends StatelessWidget {
  const PrivacyPoliciesPage({super.key});





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: black,
        centerTitle: true,
        title: const Text('Privacy Policies'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               kheight,
            Text(
              'Welcome to klik! Our Privacy Policy details the ways we collect, manage, disclose, and protect your personal information when you use our mobile app. We invite you to carefully review this policy to understand our approach to handling your data and the measures we take to ensure its security.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
            Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Personal Data: Details you share with us during registration, including your name, email address, phone number, and profile picture.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Usage Data: Insights into your app usage, such as the features accessed, the timing and duration of your activities, and other related interaction data.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight20,
              Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
            Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Provide, operate, and maintain our app: Ensure the app is functional, accessible, and effectively meets user needs.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "'Improve, personalize, and expand our app: Enhance the app's features, tailor it to user preferences, and broaden its capabilities.'",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Understand and analyze how you use our app: Gain insights into your usage patterns to better understand user behavior.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Develop new products, services, features, and functionality: Create and introduce innovative offerings and enhancements.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Communicate with you: Reach out directly or through our partners for customer support, updates, promotional information, and marketing.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Process your transactions and manage your orders: Handle your purchases and oversee order-related activities.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Find and prevent fraud: Detect and avoid fraudulent activities to protect users and maintain security.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight20,
               Text(
              'Sharing of Your Information',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
                
              ),
            ),
            kheight,
            Text(
              'Your data is not shared with external parties.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            Text(
              'Data Security',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
            Text(
              'We implement a range of administrative, technical, and physical security measures to safeguard your personal information. Although we strive to protect the data you provide with robust security practices, please note that no security system is entirely foolproof or impervious to breaches.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            Text(
              'Your Rights and Choices',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
             Text(
              'Depending on where you live, you may have the following rights with respect to your personal information:',
              style: TextStyle(fontSize: 16.0),
            ),
             Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Review and modify your personal information.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
               Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Request the deletion of your personal data.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
               Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Unsubscribe from marketing communications.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
               Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Limit the processing of your personal data.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
               Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  Baseline(
                    baseline: 20, // Adjust based on your text size
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.brightness_1, size: 8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Dispute the use of your personal information.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight20,
              Text(
              'Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            kheight,
            Text(
              'We may periodically revise this Privacy Policy to align with updates in our practices or due to operational, legal, or regulatory changes. Any updates will be communicated by posting the revised Privacy Policy on our app. We recommend that you review this policy regularly to stay informed of any modifications.',
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
            kheight,
            Text(
              'geopaul94@gmail.com',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}