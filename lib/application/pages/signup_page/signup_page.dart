import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/customeTypewriterGradientText.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/application/pages/login/login_page.dart';
import 'package:klik/application/pages/signup_page/register_otp.dart';

import 'package:klik/constants/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _phonenumberController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String email = '';

  @override
  void dispose() {
    _phonenumberController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                child: const TypewriterGradientText(
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: 'Email',
                hintText: 'Enter your email address',
                icon: Icons.email_outlined,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  email = _emailController.text;
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: "Phone Number",
                hintText: 'Enter your Phone Number',
                icon: Icons.phone_android,
                controller: _phonenumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: "Password",
                hintText: 'Enter your password',
                icon: Icons.lock,
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: "Confirm password",
                hintText: 'Enter your password',
                icon: Icons.lock,
                controller: _confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              CustomElevatedButton(
                text: "Register",
                onPressed: () {
                  print("+++++++++++++++++++++++++++$email");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterOtp(
                        email: email,
                      ),
                    ),
                  );
                  if (_formKey.currentState!.validate()) {
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Passwords do not match'),
                        ),
                      );
                    } else {
                      print('Phone Number: ${_phonenumberController.text}');
                      print('Password: ${_passwordController.text}');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Registration completed sucessufully ')),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Container(
                width: width * .8,
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
                          child: Text("Have an account ? then "),
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
                        // Navigate to another page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: CustomText(
                        text: "Login",
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
  }
}
