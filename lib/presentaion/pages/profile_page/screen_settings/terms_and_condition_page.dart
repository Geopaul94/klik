import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: black,
        centerTitle: true,
        title: const Text('Terms and Conditions'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Klik - Terms and Conditions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              kheight15,
              Text('Last Updated: October 23, 2024'),
              kheight15,
              Text(
                  'Welcome to Klik! By accessing and using our app, you acknowledge that you accept and agree to adhere to the following terms and conditions. We encourage you to review them thoroughly. If you find that you do not agree with any part of these terms, we kindly advise you to refrain from using the app.'),
              kheight15,
              Text(
                '1. Acceptance of Terms',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              kheight15,
              Text(
                  'By using or accessing Klik, you accept and agree to be governed by these Terms and Conditions and our Privacy Policy. If you disagree with any part of these terms, you should not use our services.'),
              kheight15,
              Text(
                '2. User Accounts',
                style: TextStyle(fontWeight: FontWeight.bold),
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
                      'Account Creation: To access Klik, you need to register by providing a valid email address and accurate personal details.',
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
                      'Account Security: You are responsible for keeping your account credentials and password secure and for managing access to your device. You agree to be accountable for any actions performed through your account.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight15,
              Text(
                '3. Privacy and Data Security',
                style: TextStyle(fontWeight: FontWeight.bold),
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
                      'Data Collection: Your personal data is collected and processed in accordance with our Privacy Policy.',
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
                      'Data Encryption: Klik safeguards your data with industry-standard encryption, ensuring protection against unauthorized access.',
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
                      'Data Safety: We prioritize the confidentiality and security of your information by applying robust security measures to keep your personal data safe.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight15,
              Text(
              '4. User Conduct',
              style: TextStyle( fontWeight: FontWeight.bold),
            ),
            Text(
              'You agree not to use Klik to:',
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
                      'Post content that is illegal, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, or otherwise objectionable.',
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
                      'Engage in activities that violate local, state, national, or international laws.',
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
                      'Harass, threaten, or impersonate others, including individuals or entities.',
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
                      'Utilize Klik for any unauthorized or unapproved commercial purposes.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight15,
              Text(
              '5. Content Ownership and Rights',
              style: TextStyle( fontWeight: FontWeight.bold),
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
                      'Ownership of Your Content: You maintain full rights to everything you share on Klik. However, by sharing, you provide Klik with a global, non-exclusive, royalty-free license to use, distribute, reproduce, and display your content.',
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
                      "'Klik's Intellectual Property: All other materials on Klik, including but not limited to text, images, logos, and software, are owned by Klik or its licensors and are protected under intellectual property laws.'",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight15,
              Text(
              '6. Modifications to the Service',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Service Changes: Klik reserves the right to modify, suspend, or permanently discontinue the service, or any part of it, at any time, with or without notice. You acknowledge that Klik is not responsible to you or any third party for any such changes or interruptions.'),
            kheight15,
            Text(
              '7. Termination',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Account Suspension or Termination: Klik may, at its sole discretion and without prior notice, suspend or terminate your account and access to the service if we believe your conduct breaches these Terms and Conditions, harms other users, or negatively impacts Klik or third parties.'),
            kheight15,
             Text(
              '8. Disclaimers and Limitation of Liability',
              style: TextStyle(fontWeight: FontWeight.bold),
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
                      """'Service "As Is": Klik is provided on an "as is" and "as available" basis. We do not guarantee that the service will always be uninterrupted, secure, or free of errors.'""",
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
                      "'Liability Limitation: Klik shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits, data, use, goodwill, or other intangible losses arising from (i) your use or inability to use the service; (ii) unauthorized access to or use of our servers or personal data; (iii) bugs, viruses, or other harmful components transmitted via the service; (iv) errors or omissions in content or any loss or damage resulting from content made available through the service.'",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              kheight15,
              Text(
              '9. Governing Law',
              style: TextStyle( fontWeight: FontWeight.bold),
            ),
            Text('Governing Law: These Terms and Conditions are governed by the laws of [Your Jurisdiction], excluding any conflict of law principles that might lead to the application of laws from another jurisdiction.'),
            kheight15,
            Text(
              '10. Changes to Terms and Conditions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Terms Updates: Klik may update these terms periodically. The latest version will be accessible on our website. By continuing to use Klik after updates take effect, you agree to the revised terms.'),
            kheight15,
              Text(
              '11. Contact Us',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Contact Us: For any inquiries regarding these Terms and Conditions, please reach out to us at geopaul94@gmail.com'),
            ],
          ),
        ),
      ),
    );
  }
}
