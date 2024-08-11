import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';

import 'package:klik/application/core/widgets/CustomText.dart';

import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/application/core/widgets/validations.dart';
import 'package:klik/presentaion/bloc/login/otp_verification/otp_verify_bloc.dart';
import 'package:klik/presentaion/bloc/login/resetpassword/resetpassword_bloc.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';

class ResetPasswordPage extends StatelessWidget {final String email;
  ResetPasswordPage({super.key, required this.email});

  final newpasswoedcontroller = TextEditingController();
  
  final confirmpasswoedcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return BlocConsumer<ResetpasswordBloc, ResetpasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccesState) {
          customSnackbar(context, "Otp verified", green);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        } else if (state is ResetPasswordErrorState) {
          customSnackbar(context, state.error, red);
        }
      },
      builder: (context, state) {
        return 
        
        
          GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
              padding: EdgeInsets.all(
                size.height * .045,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .08,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.height * .02,
                      ),
                      SizedBox(
                        height: size.height * .15,
                        width: size.height * .3,
                        child: Image.asset("assets/headline.png"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  CustomeLinearcolor(
                    text: "Enter New Password",
                    fontSize: 20,
                    gradientColors: [green, blue],
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  CustomText(
                    text:
                        "Once you reset your password , You can login to   \n your account using that password ",
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: size.height * .025,
                  ),
                  Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: CustomTextFormField(
                      labelText: "Passowrd",
                      icon: Icons.lock,
                      controller: newpasswoedcontroller,
                      validator: validatePassword,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  CustomTextFormField(
                    labelText: "Confirm passowrd",
                    icon: Icons.lock,
                    hintText: 'Re-enter new password',
                    controller: confirmpasswoedcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != newpasswoedcontroller.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  BlocBuilder<ResetpasswordBloc, ResetpasswordState>(
                    builder: (context, state) {
                      if (state is ResetPasswordLoadingState) {
                        return loadingButton(
                            media: size,
                            onPressed: () {},
                            gradientStartColor: green,
                            gradientEndColor: blue,
                            loadingIndicatorColor: purple);
                      }
                      return CustomElevatedButton(
                        text: "Save",
                        fontSize: size.height * .035,
                        height: size.height * .075,
                        width: size.width * 1,
                        onPressed: () {
                           if (_formKey.currentState!
                                              .validate()) {
                                            context.read<ResetpasswordBloc>().add(
                                                OnResetPasswordButtonClickedEvent(
                                                    email: email,
                                                    password:
                                                        confirmpasswoedcontroller
                                                            .text)
                                                            
                                                            
                                                            
                                                            );
                                          } else {
                                            customSnackbar(context,
                                                'Please fix the errors', red);
                                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ))),
          ),
        );
      },
    );
  }
}
