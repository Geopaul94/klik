import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to  search page!',
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
