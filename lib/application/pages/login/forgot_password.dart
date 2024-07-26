import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/constants/constants.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPassword extends StatelessWidget {
  final emailcontroller = TextEditingController();
  ForgotPassword({super.key, required emailcontroller});

  final otpController = OtpFieldController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // child: Image.asset(
              //   'assets/email.png',
              //   width: MediaQuery.of(context).size.width * 0.35,
              //   height: MediaQuery.of(context).size.height * 0.15,
              //   fit: BoxFit.cover,
              // ),

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
                    // Handle completed OTP
                    print("Entered OTP: $pin");
                    // You can add your verification logic here
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
    );
  }
}
