import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomeAppbar.dart';
import 'package:klik/application/core/widgets/custome_button.dart';

class UserPost extends StatelessWidget {
  const UserPost({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: "New Post ",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.all(20),
          child: ListView(
            children: <Widget>[
              Text(
                'Welcome to  search page!',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              SizedBox(  height: size.height*.075,
                 width: size.height*.5,
               
              )
            ],
          ),
        ),
      ),
    );
  }
}
