import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/presentaion/pages/login/reset_password_page.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyotpPage extends StatelessWidget {
  VerifyotpPage({super.key, required emailcontroller});

  final otpController = OtpFieldController();
  final emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    children: [
                      // Grey circular background
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        width: MediaQuery.of(context).size.width * 0.36,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      // Image on top of the grey background
                      Positioned(
                        left: MediaQuery.of(context).size.width *
                            0.006, // 5% from the left
                        top: MediaQuery.of(context).size.height * 0.015,
                        child: Lottie.asset(
                          'assets/otp.json',
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                CustomText(
                  text:
                      "Enter the verification code that was sent to ${emailcontroller.text}",
                  color: Colors.white,
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: PinCodeTextField(
                    length: 4,
                    onChanged: (pin) {
                      print("Changed: " + pin);
                    },
                    appContext: context,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.grey[200],
                      selectedFillColor: Colors.blue[100],
                    ),
                    onCompleted: (pin) {
                      print("Entered OTP: $pin");
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomElevatedButton(
                  text: "Verify",
                  fontSize: 40,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordPage()));
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Didn't get the code ?",
                        color: Colors.white,
                      ),
                      CustomText(text: " Resend ?", color: green),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
