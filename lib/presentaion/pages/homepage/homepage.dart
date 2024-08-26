import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: height * 0.09,  
            width: width * 0.04,  
            child: Image.asset(
              'assets/headline.png',
              fit: BoxFit.contain,  
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.person_add_solid,
              size: height * 0.04, 
            ),
          ),
        ],
      ),
      body: Center(child: Text('Hello, World!')),
    );
  }
}
