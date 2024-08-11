import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';

import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/application/core/widgets/validations.dart';
import 'package:klik/presentaion/bloc/login/forgorpassword_mailclicked/forgotpassword_bloc.dart';



import 'package:klik/presentaion/pages/authentication/login/resetpassowrdOtp.dart';

class EntermailidLogin extends StatelessWidget {
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: 
      
      
       GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      
       child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back,
                  color: Colors.white, size: 30.0), 
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: BlocConsumer<ForgotpasswordBloc, ForgotpasswordState>(
            listener: (context, state) {
              if (state is ForgotpasswordSucessState) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                     Resetpassowrdotp( email:_emailController.text,),
                 ) );
              } else if (state is ForgotpasswordErrorState) {
                customSnackbar(context, state.error, red);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenWidth * .15,
                        ),
                        CustomText(
                          text: "Forgot Password ?",
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: screenWidth * .050,
                        ),
                        CustomText(
                          text: "Don't worry Please enter your email id .",
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: screenWidth * .075,
                        ),
                        Container(
                          height: screenWidth * .4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: screenWidth * .7,
                            height: screenWidth * .35,
                            child: Image.asset(
                              'assets/email.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenWidth * .15,
                        ),
                        CustomTextFormField(
                            labelText: "Email Address",
                            icon: Icons.mail,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail),
                        SizedBox(
                          height: screenWidth * .075,
                        ),
                        BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
                          builder: (context, state) {
                            if (state is ForgotpasswordLoadingstate) {
                              return loadingButton(
                                  media: size,
                                  onPressed: () {},
                                  gradientStartColor: green,
                                  gradientEndColor: blue,
                                  loadingIndicatorColor: purple);
                            }
                            return CustomElevatedButton(
                              width: screenWidth * .9,
                              text: "Submit",
                              onPressed: () => _handleSubmit(context),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {FocusScope.of(context).unfocus();
      context.read<ForgotpasswordBloc>().add(onMailidSubmittedButtonClicked(
            email: _emailController.text,
          ));
    }
  }
}




