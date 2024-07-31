import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/CustomeAppbar.dart';
import 'package:klik/application/core/constants/constants.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegisterOtp extends StatelessWidget {
  final String email;
  RegisterOtp({
    super.key,
    required this.email,
  });

  final otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    print("========================================$email");

    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'OTP Verification',
        leadingIcon: Icons.arrow_back,
        leadingIconSize: 32.0,
        cupertinoLeadingIcon: CupertinoIcons.back,
        isTitleBold: true,
        titleStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        startColor: green,
        endColor: Colors.blue,
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
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.03,
                        top: MediaQuery.of(context).size.height * 0.04,
                        child: Image.asset(
                          'assets/email.png',
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Enter the verification code that was sent to ",
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomText(
                      text: email,
                      color: green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.06,
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
                  onPressed: () {},
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
