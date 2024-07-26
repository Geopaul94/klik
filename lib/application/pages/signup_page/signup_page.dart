import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/customeTypewriterGradientText.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/application/pages/login/login_page.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 100.0),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/headline.png'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
