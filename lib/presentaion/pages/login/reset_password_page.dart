import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomLoadingButton.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/presentaion/pages/login/login_page.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});
  final newpasswoedcontroller = TextEditingController();
  final confirmpasswoedcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .06,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * .05,
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                CustomText(
                  text: "Reset Passowrd",
                  fontSize: 34,
                  color: green,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: size.height * .02,
            ),
            CustomText(
              text: "Enter New Password ",
              fontSize: 20,
              color: white,
            ),
            SizedBox(
              height: size.height * .02,
            ),
            CustomText(
              text:
                  "Your new password must be different \n from previously used password ",
              color: Colors.grey,
            ),
            CustomTextFormField(
                labelText: "Passowrd",
                icon: Icons.lock,
                controller: newpasswoedcontroller),
            CustomTextFormField(
                labelText: "Confirm passowrd",
                icon: Icons.lock,
                controller: confirmpasswoedcontroller),
            SizedBox(
              height: size.height * .02,
            ),
            CustomElevatedButton(
              text: "Save",
              onPressed: () => LoginPage(),
              fontSize: 28.0, // Custom font size
              height: size.height * .09, // Custom height (optional)
              width: size.width * 1, // Custom width (optional)
            ),
          ],
        ),
      ))),
    );
  }
}
