import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/CustomeAppbar.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_icons.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/domain/model/userModel.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegisterOtp extends StatelessWidget {
  final UserModel user;
  final String email;

  RegisterOtp({
    super.key,
    required this.email,
    required this.user,
  });

  final otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sizedbox(height),
                    rowheadline(height: height),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: email_image(context),
                    ),
                    SizedBox(
                      height: height * 0.05,
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
                      height: height * 0.05,
                    ),
                    otpbox(context),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    CustomElevatedButton(
                      text: "Verify",
                      fontSize: 28,
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    resentotptext(height),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell resentotptext(double height) {
    return InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Didn't get the code ?",
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: height * 0.015,
                        ),
                        CustomText(
                            text: " Resend ",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: green),
                      ],
                    ),
                  );
  }

  Container otpbox(BuildContext context) {
    return Container(
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
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.grey[200],
                        selectedFillColor: Colors.blue[100],
                      ),
                      onCompleted: (pin) {
                        print("Entered OTP: $pin");
                      },
                    ),
                  );
  }

  SizedBox sizedbox(double height) {
    return SizedBox(
                    height: height * 0.06,
                  );
  }

  Stack email_image(BuildContext context) {
    return Stack(
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
                          top: MediaQuery.of(context).size.height * 0.035,
                          child: Image.asset(
                            'assets/email.png',
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.15,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    );
  }
}

class rowheadline extends StatelessWidget {
  const rowheadline({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomGradientIcon(
          icon: CupertinoIcons.back,
          size: 32.0,
          gradientColors: [Colors.blue, Colors.green],
        ),
        SizedBox(
          width: height * 0.05,
        ),
        CustomeLinearcolor(
          text: 'Enter the OTP',
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          gradientColors: [
            Colors.green,
            Colors.blue,
          ],
        ),
      ],
    );
  }
}
