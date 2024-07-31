import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to  home page!',
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20),

            // ElevatedButton(

            //   onPressed: () {

            //     // Add your button press logic here

            //   },

            //   child: Text('Click me!'),

            // ),
          ],
        ),
      ),
    );
  }
}
