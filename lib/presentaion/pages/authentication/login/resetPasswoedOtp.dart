import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customMaterialButton.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/application/core/widgets/textBoxwidget.dart';

import 'package:klik/application/core/widgets/validations.dart';
import 'package:klik/presentaion/bloc/login/forgorpassword/forgotpassword_bloc.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';

class resetPasswordOtp extends StatefulWidget {
  final String email;

  resetPasswordOtp({
    super.key,
    required emailcontroller,
    required this.email,
  });

  @override
  State<resetPasswordOtp> createState() => _resetPasswordOtpState();
}

class _resetPasswordOtpState extends State<resetPasswordOtp> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController _newPassWordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return BlocConsumer<ForgotpasswordBloc, ForgotpasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccesState) {
          customSnackbar(context, 'password reset succesfull', green);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const LoginPage();
            }),
            (Route<dynamic> route) => false,
          );
        } else if (state is OtpverifiedErrorState) {
          customSnackbar(context, state.error, red);
        } else if (state is ResetPasswordErrorState) {
          customSnackbar(context, state.error, red);
        }
      },
      builder: (context, state) {
        return BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
          builder: (context, state) {
            if (state is OtpverifiedSuccesState) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Reset password',
                    style: TextStyle(color: Colors.green),
                  ),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: media.height,
                      width: media.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: media.height * 0.15,
                              child: Image.asset("assets/headline.png")),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: media.height * 0.4,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextFormField(
                                    icon: Icons.lock,
                                    labelText: "passowrd",
                                    hintText: 'Enter new password',
                                    controller: _newPassWordController,
                                    validator: validatePassword,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFormField(
                                    icon: Icons.lock,
                                    labelText: "Confirm password",
                                    hintText: 'Re-enter new password',
                                    controller: _confirmPasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                      if (value !=
                                          _newPassWordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  BlocBuilder<ForgotpasswordBloc,
                                      ForgotpasswordState>(
                                    builder: (context, state) {
                                      if (state is ResetPasswordLoadingState) {
                                        return loadingButton(
                                            media: media,
                                            onPressed: () {},
                                            gradientStartColor: green,
                                            gradientEndColor: blue,
                                            loadingIndicatorColor: purple);
                                      }

                                      return customButton(
                                        media: media,
                                        buttonText: 'Save',
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<ForgotpasswordBloc>().add(
                                                OnResetPasswordButtonClickedEvent(
                                                    email: widget.email,
                                                    password:
                                                        _confirmPasswordController
                                                            .text));
                                          } else {
                                            customSnackbar(context,
                                                'Please fix the errors', red);
                                          }
                                        },
                                        color: green,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter the OTP',
                        style: TextStyle(color: green),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'We have sent you an OTP to your registred email. ',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: media.height * 0.3,
                        child: Image.asset('assets/g_logo.png'),
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
                      const SizedBox(
                        height: 50,
                      ),
                      BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
                        builder: (context, state) {
                          if (state is OtpverifiedLoadingState) {
                            return loadingButton(
                                media: media,
                                onPressed: () {},
                                gradientStartColor: green,
                                gradientEndColor: blue,
                                loadingIndicatorColor: purple);
                          }
                          return customMaterialButton(
                            borderRadius: 20,
                            onPressed: () async {
                              if (validateOtp()) {
                                String otp = _controllers
                                    .map((controller) => controller.text)
                                    .join();
                                debugPrint('Entered OTP: $otp');

                                context.read<ForgotpasswordBloc>().add(
                                    onVerifiPasswordButtonClicked(
                                        email: widget.email, otp: otp));

                                for (var controller in _controllers) {
                                  controller.clear();
                                }
                              } else {
                                customSnackbar(
                                    context,
                                    'Please enter a valid 4-digit OTP',
                                    Colors.red);
                              }
                            },
                            text: 'Verify',
                            color: green,
                            width: media.width,
                            height: media.height * 0.05,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
