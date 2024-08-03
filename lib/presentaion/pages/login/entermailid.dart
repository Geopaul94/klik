import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/presentaion/pages/login/reset_password_page.dart';
import 'package:klik/presentaion/pages/login/reserPasswoedOtp.dart';

class EntermailidLogin extends StatelessWidget {
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
                color: Colors.white, size: 30.0), // Adjust size here
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
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
                    height: screenWidth * .2,
                  ),
                  CustomTextFormField(
                    labelText: "Email Address",
                    icon: Icons.mail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenWidth * .15,
                  ),
                  CustomElevatedButton(
                    width: screenWidth * .9,
                    text: "Submit",
                    onPressed: () => _handleSubmit(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => resetPasswordOtp(emailcontroller: _emailController),
    ));
    if (_formKey.currentState!.validate()) {
      // final email = _emailController.text;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Email entered: $email')),
      // );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            resetPasswordOtp(emailcontroller: _emailController),
      ));
    }
  }
}
