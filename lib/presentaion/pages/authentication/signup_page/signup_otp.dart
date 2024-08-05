import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_icons.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/domain/model/userModel.dart';

import 'package:klik/presentaion/bloc/signup/signup_bloc.dart';
import 'package:klik/presentaion/bloc/signupotp/signup_otp_bloc.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegisterOtp extends StatefulWidget {
  final UserModel user;
  final String email;

  RegisterOtp({
    super.key,
    required this.email,
    required this.user,
  });

  @override
  State<RegisterOtp> createState() => _RegisterOtpState();
}

class _RegisterOtpState extends State<RegisterOtp> {
  late Timer _timer;
  Timer? _debounceTimer;
  String otp = '';
  int _start = 60;
  bool _isResendVisible = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _isResendVisible = false;
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendVisible = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void debounceResendOtp(SignupBloc signUpBloc) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      signUpBloc.add(OnRegisterButtonClickedEvent(
          userName: widget.user.userName,
          password: widget.user.password,
          phoneNumber: widget.user.phoneNumber,
          email: widget.user.emailId));
      startTimer(); // Restart the timer
    });
  }

  bool validateOtp() {
    debugPrint('OTP from PinCodeTextField: $otp');
    if (otp.length == 4 && RegExp(r'^[0-9]{4}$').hasMatch(otp)) {
      return true;
    } else {
      debugPrint(
          'Validation failed: OTP is either not 4 digits or contains non-numeric characters');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignupBloc>();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      body: BlocConsumer<SignupOtpBloc, SignupOtpState>(
        listener: (context, state) {
          if (state is SignupOtpSucessState) {
            customSnackbar(context, "OTP verification success", green);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (Route<dynamic> route) => false,
            );
          } else if (state is SignupOtpErrorState) {
            customSnackbar(context, "Invalid OTP", Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Row(
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
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.25,
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
                              top: MediaQuery.of(context).size.height * 0.035,
                              child: Image.asset(
                                'assets/email.png',
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        )),
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
                          text: widget.email,
                          color: green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: PinCodeTextField(
                        length: 4,
                        onChanged: (value) {
                          otp = value;
                          debugPrint("OTP changed: $value");
                        },
                        appContext: context,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: Colors.white,
                        ),
                        onCompleted: (pin) {
                          otp = pin;
                          debugPrint("Entered OTP: $pin");
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    BlocBuilder<SignupOtpBloc, SignupOtpState>(
                      builder: (context, state) {
                        if (state is SignupOtpILoadingState) {
                          return loadingButton(
                              media: size,
                              onPressed: () {},
                              gradientStartColor: Colors.blue,
                              gradientEndColor: green,
                              loadingIndicatorColor: Colors.purple);
                        }
                        return CustomElevatedButton(
                          text: "Verify",
                          fontSize: 28,
                          onPressed: () async {
                            if (validateOtp()) {
                              debugPrint('Entered OTP: $otp');
                              context.read<SignupOtpBloc>().add(
                                  onOtpVerificationButtonClickedEvent(
                                      otp: otp, email: widget.email));
                            } else {
                              debugPrint('Invalid OTP: $otp');
                              customSnackbar(
                                  context,
                                  'Please enter a valid 4-digit OTP',
                                  Colors.red);
                            }
                          },
                        );
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
                            text: "Didn't get the code?",
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: height * 0.015,
                          ),
                        ],
                      ),
                    ),
                    _isResendVisible
                        ? TextButton(
                            onPressed: () {
                              debounceResendOtp(signUpBloc);
                            },
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(color: white, fontSize: 16),
                            ),
                          )
                        : Text(
                            'Resend OTP in $_start seconds',
                            style: const TextStyle(color: green, fontSize: 16),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
