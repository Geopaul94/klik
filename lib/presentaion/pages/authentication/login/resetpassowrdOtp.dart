import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';

import 'package:klik/application/core/widgets/customMaterialButton.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_icons.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/textBoxwidget.dart';
import 'package:klik/presentaion/bloc/login/otp_verification/otp_verify_bloc.dart';
import 'package:klik/presentaion/pages/authentication/login/reset_password_page.dart';

class Resetpassowrdotp extends StatefulWidget {
  const Resetpassowrdotp({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<Resetpassowrdotp> createState() => _ResetpassowrdotpState();
}

class _ResetpassowrdotpState extends State<Resetpassowrdotp> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validateOtp() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty ||
          controller.text.length != 1 ||
          !RegExp(r'^[0-9]$').hasMatch(controller.text)) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: BlocConsumer<OtpVerifyBloc, OtpVerifyState>(
        listener: (context, state) {
          if (state is OtpverifiedSuccesState) {
            debugPrint("OTP verified successfully.");
            customSnackbar(context, "OTP verified", green);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return ResetPasswordPage(email: widget.email);
              },
            ));
          } else if (state is OtpverifiedErrorState) {
            debugPrint("OTP verification error: ${state.error}");
            customSnackbar(context, state.error, red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.2, horizontal: size.height * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          debugPrint("OTP page back arrow pressed");
                          Navigator.of(context).pop();
                          debugPrint('Back navigation in the OTP change page');
                        },
                        child: CustomGradientIcon(
                          icon: CupertinoIcons.back,
                          size: 40,
                        ),
                      ),
                      SizedBox(width: size.height * 0.040),
                      CustomeLinearcolor(
                        text: "Enter the OTP",
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        gradientColors: [green, blue],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.031),
                  const Text(
                    'We have sent you an OTP to your registered email.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.25,
                    width: size.height * 0.6,
                    child: Image.asset('assets/otpsent.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) {
                      return textBoxWidget(
                        context: context,
                        controller: _controllers[index],
                      );
                    }),
                  ),
                  const SizedBox(height: 50),
                  BlocBuilder<OtpVerifyBloc, OtpVerifyState>(
                    builder: (context, state) {
                      if (state is OtpverifiedLoadingState) {
                        return loadingButton(
                          media: size,
                          onPressed: () {},
                          gradientStartColor: green,
                          gradientEndColor: blue,
                          loadingIndicatorColor: purple,
                        );
                      }
                      return customMaterialButton(
                        borderRadius: 10,
                        onPressed: () async {
                          if (validateOtp()) {
                            String otp = _controllers
                                .map((controller) => controller.text)
                                .join();
                            debugPrint('Entered OTP: $otp');
                            context.read<OtpVerifyBloc>().add(
                                onVerifiPasswordButtonClicked(
                                    otp: otp, email: widget.email));
                          } else {
                            customSnackbar(
                              context,
                              'Please enter a valid 4-digit OTP',
                              Colors.red,
                            );
                          }
                        },
                        text: 'Verify',
                        color: Colors.green,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
