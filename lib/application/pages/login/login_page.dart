import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/application/pages/login/forgot_password.dart';
import 'package:klik/application/features/authentication/loginbloc/login_bloc.dart';
import 'package:klik/application/features/authentication/loginbloc/login_event.dart';
import 'package:klik/application/features/authentication/loginbloc/login_state.dart';
import 'package:klik/application/pages/signup_page/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Login '),
        ),
        // body: BlocListener<LoginBloc, LoginState>(
        //   listener: (context, state) {
        //     if (state is LoginSuccess) {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => SignupPage()),
        //       );
        //     } else if (state is LoginFailure) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(content: Text(state.error)),
        //       );
        //     }
        //   },
        //   child:
        //
        //
        //
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: height * .2,
                    ),
                    CustomTextFormField(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      icon: Icons.person,
                      controller: emailcontroller,
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
                                  builder: (context) => ForgotPassword(
                                        emailcontroller: emailcontroller,
                                      )),
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
                    CustomElevatedButton(
                      text: 'Sign in',
                      onPressed: () {},
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
                    GestureDetector(
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
                      onTap: () {
                        print("row pressed");
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
                          width: width * .05,
                        ),
                        GestureDetector(
                          child: CustomText(
                            text: "Sign up ",
                            color: Colors.green,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return SignupPage();
                              },
                            ));
                          },
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    // final username = emailcontroller.text;
                    // final password = _passwordController.text;
                    // // context.read<LoginBloc>().add(
                    //       LoginButtonPressed(
                    //           username: username, password: password),
                    //     );
                    //   },
                    //   child: Text('Login'),
                    // )
                  ],
                ),
              ),
            )));
  }
}
