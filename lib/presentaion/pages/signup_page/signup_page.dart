// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
// import 'package:klik/application/core/widgets/CustomText.dart';
// import 'package:klik/application/core/widgets/customeTypewriterGradientText.dart';
// import 'package:klik/application/core/widgets/custome_button.dart';
// import 'package:klik/application/core/widgets/custome_snackbar.dart';
// import 'package:klik/application/core/widgets/customepassword.dart';
// import 'package:klik/application/core/widgets/custometextformfield.dart';
// import 'package:klik/application/core/widgets/validations.dart';
// import 'package:klik/domain/model/userModel.dart';
// import 'package:klik/presentaion/bloc/signup/signup_bloc.dart';
// import 'package:klik/presentaion/pages/login/login_page.dart';
// import 'package:klik/presentaion/pages/signup_page/signup_otp.dart';

// import 'package:klik/application/core/constants/constants.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _phoneController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   String email = '';

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;

//     return Scaffold(
//         body: BlocConsumer<SignupBloc, SignupState>(
//       listener: (context, state) {
//         if (state is SignupSuccesState) {
//           customSnackbar(context, 'success', green);

//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => RegisterOtp(
//                 email: _emailController.text,
//                 user: UserModel(
//                     userName: _usernameController.text,
//                     password: _passwordController.text,
//                     phoneNumber: _phoneController.text,
//                     emailId: _emailController.text),
//               ),
//             ),
//           );
//         } else if (state is SignupErrorState) {
//           customSnackbar(context, state.error, red);
//         }
//       },
//       builder: (context, state) {
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(22.0),
//             child: Form(
//               autovalidateMode: AutovalidateMode.always,
//               key: _formKey,
//               child: ListView(
//                 children: <Widget>[
//                   const SizedBox(height: 50.0),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 40),
//                     child: SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: Image.asset('assets/headline.png'),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   const Center(
//                     child: const TypewriterGradientText(
//                       text:
//                           ' " Capture the essence of your most beautiful memories with Klik. Let your clicks tell stories that will last a lifetime, sharing joy and love with every shot. " ',
//                       style: colorizeTextStyle,
//                       gradient: gradient,
//                       speed: Duration(milliseconds: 100),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   CustomTextFormField(
//                     labelText: 'Username',
//                     icon: Icons.person_outline,
//                     controller: _usernameController,
//                     validator: validateUsername,
//                   ),
//                   const SizedBox(height: 16.0),
//                   CustomTextFormField(
//                       labelText: 'Email',
//                       hintText: 'Enter your email address',
//                       icon: Icons.email_outlined,
//                       controller: _emailController,
//                       validator: validateEmail),
//                   const SizedBox(height: 16.0),
//                   CustomTextFormField(
//                     labelText: "Phone Number",
//                     hintText: 'Enter your Phone Number',
//                     icon: Icons.phone_android,
//                     controller: _phoneController,
//                     validator: validateMobileNumber,
//                     keyboardType: TextInputType.phone,
//                   ),
//                   const SizedBox(height: 16.0),
//                   CustomTextFormField(
//                       labelText: "Password",
//                       hintText: 'Enter your password',
//                       icon: Icons.lock,
//                       controller: _passwordController,
//                       obscureText: true,
//                       validator: validatePassword),
//                   const SizedBox(height: 16.0),
//                   CustomTextFormField(
//                     labelText: "Confirm password",
//                     hintText: 'Enter your password',
//                     icon: Icons.lock,
//                     controller: _confirmPasswordController,
//                     obscureText: true,
//                     // validator: validateConfirmPassword
//                   ),

//                   // CustomPasswordField(controller: _passwordController, labelText: 'passo',),
//                   const SizedBox(height: 24.0),
//                   BlocBuilder<SignupBloc, SignupState>(
//                     builder: (context, state) {
//                       if (state is SignupLoadingState) {
//                         return loadingButton(
//                           media: size,
//                           onPressed: () {},
//                           gradientStartColor: Colors.green,
//                           gradientEndColor: Colors.blue,
//                           loadingIndicatorColor: Colors.purple,
//                         );
//                       }
//                       return customButton(
//                           color: Colors.green,
//                           media: size,
//                           buttonText: 'Register',
//                           onPressed: () async {
//                             if (_passwordController.text ==
//                                 _confirmPasswordController.text) {
//                               if (_formKey.currentState!.validate()) {
//                                 context.read<SignupBloc>().add(
//                                     OnRegisterButtonClickedEvent(
//                                         userName: _usernameController.text,
//                                         password: _passwordController.text,
//                                         phoneNumber: _phoneController.text,
//                                         email: _emailController.text));
//                               } else {
//                                 customSnackbar(context, 'Fill All Fields', red);
//                               }
//                               // else{
//                               //  customSnackbar(context, 'something went wrong', red);
//                               // }
//                             } else {
//                               customSnackbar(
//                                   context, 'Password miss match', red);
//                             }
//                           });
//                     },
//                   ),
//                   SizedBox(height: 12.0),
//                   Container(
//                     width: width * .8,
//                     child: Column(
//                       children: [
//                         const Row(
//                           children: [
//                             Expanded(
//                               child: Divider(
//                                 color: Colors.white,
//                                 thickness: 1,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Text("Have an account ? then "),
//                             ),
//                             Expanded(
//                               child: Divider(
//                                 color: Colors.white,
//                                 thickness: 1,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12.0),
//                         InkWell(
//                           onTap: () {
//                             // Navigate to another page
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginPage()),
//                             );
//                           },
//                           child: CustomText(
//                             text: "Login",
//                             color: Colors.green,
//                             fontSize: 22,
//                             decoration: TextDecoration.none,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 80.0),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/customeTypewriterGradientText.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/application/core/widgets/validations.dart';
import 'package:klik/domain/model/userModel.dart';
import 'package:klik/presentaion/bloc/signup/signup_bloc.dart';
import 'package:klik/presentaion/pages/login/login_page.dart';
import 'package:klik/presentaion/pages/signup_page/signup_otp.dart';
import 'package:klik/application/core/constants/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccesState) {
            customSnackbar(context, 'Success', green);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RegisterOtp(
                  email: _emailController.text,
                  user: UserModel(
                    userName: _usernameController.text,
                    password: _passwordController.text,
                    phoneNumber: _phoneController.text,
                    emailId: _emailController.text,
                  ),
                ),
              ),
            );
          } else if (state is SignupErrorState) {
            customSnackbar(context, state.error, red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/headline.png'),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Center(
                      child: TypewriterGradientText(
                        text:
                            ' " Capture the essence of your most beautiful memories with Klik. Let your clicks tell stories that will last a lifetime, sharing joy and love with every shot. " ',
                        style: colorizeTextStyle,
                        gradient: gradient,
                        speed: Duration(milliseconds: 100),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      labelText: 'Username',
                      icon: Icons.person_outline,
                      controller: _usernameController,
                      validator: validateUsername,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      labelText: 'Phone Number',
                      hintText: 'Enter your Phone Number',
                      icon: Icons.phone_android,
                      controller: _phoneController,
                      validator: validateMobileNumber,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      icon: Icons.lock,
                      controller: _passwordController,
                      obscureText: true,
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      labelText: 'Confirm password',
                      hintText: 'Enter your password',
                      icon: Icons.lock,
                      controller: _confirmPasswordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        if (state is SignupLoadingState) {
                          return loadingButton(
                            media: size,
                            onPressed: () {},
                            gradientStartColor: Colors.green,
                            gradientEndColor: Colors.blue,
                            loadingIndicatorColor: Colors.purple,
                          );
                        }
                        return customButton(
                          color: Colors.green,
                          media: size,
                          buttonText: 'Register',
                          onPressed: () {
                            if (_passwordController.text ==
                                _confirmPasswordController.text) {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignupBloc>().add(
                                  OnRegisterButtonClickedEvent(
                                    userName: _usernameController.text,
                                    password: _passwordController.text,
                                    phoneNumber: _phoneController.text,
                                    email: _emailController.text,
                                  ),
                                );
                              } else {
                                customSnackbar(context, 'Fill All Fields', red);
                              }
                            } else {
                              customSnackbar(context, 'Password mismatch', red);
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      width: size.width * .8,
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Have an account? Then '),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: CustomText(
                              text: 'Login',
                              color: Colors.green,
                              fontSize: 22,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80.0),
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
