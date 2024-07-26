import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class RegisterOtp extends StatelessWidget {
  RegisterOtp({super.key});

  final otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.cleaning_services),
        onPressed: () {
          print("Floating button was pressed.");
          otpController.clear();
          //  otpController.set(['2', '3', '5', '5', '7']);
          otpController.setValue('3', 0);
          otpController.setFocus(1);
        },
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: OTPTextField(
                  controller: otpController,
                  length: 5,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomElevatedButton(
                text: "Verify",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
