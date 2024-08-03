import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';

import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/presentaion/bloc/login/login_bloc.dart';
import 'package:klik/presentaion/pages/bottomnavBAr/bottomNavBar.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/login/entermailid.dart';
import 'package:klik/presentaion/pages/login/reset_password_page.dart';

import 'package:klik/presentaion/pages/signup_page/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final userNamecontroller = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    userNamecontroller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogingSucessState) {
          customSnackbar(context, "Welcome", green);

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return BottomNavBar();
            },
          ), (Route<dynamic> route) => false);
        } else if (state is LogingLoadingErrorState) {
          customSnackbar(context, state.error, red);
        }
      },
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Container(
                    //   height: height * .2,
                    // ),
                    SizedBox(
                      height: height * .08,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/headline.png'),
                      ),
                    ),
                    CustomTextFormField(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      icon: Icons.person,
                      controller: userNamecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      icon: Icons.lock,
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EntermailidLogin()),

                              //  builder: (context) =>Entermailid())
                            );
                          },
                          child: const Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.04),

                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LogingLoadingState) {
                          return loadingButton(
                              media: size,
                              onPressed: () {},
                              gradientStartColor: green,
                              gradientEndColor: blue,
                              loadingIndicatorColor: purple);
                        }

                        return CustomElevatedButton(
                          text: 'Login',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                  onLoginButtonClickedEvent(
                                      email: userNamecontroller.text,
                                      password: _passwordController.text));
                            } else {
                              customSnackbar(
                                  context, "Fill all the fields", red);
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: height * 0.04),

                    Container(
                      width: width * .8,
                      child: const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("or  With"),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LogingoogleButtonState) {
                          return CircularProgressIndicator();
                        }
                        return GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/g_logo.png',
                                width: width * 0.12,
                                height: height * 0.075,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: width * 0.02),
                              const Text("Sign in with Google"),
                            ],
                          ),
                          onTap: () async {
                            context
                                .read<LoginBloc>()
                                .add(onGoogleButtonClickedEvent());

                            print("google button pressed");
                          },
                        );
                      },
                    ),

                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Don't have account ? Let's ",
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: width * .03,
                        ),
                        GestureDetector(
                          child: CustomText(
                            text: "Sign up ",
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () {
                            print(
                                "+++++++++++++++++++++++++++++++++++signup pressed");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return SignupPage();
                              },
                            ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    ));
  }
}
