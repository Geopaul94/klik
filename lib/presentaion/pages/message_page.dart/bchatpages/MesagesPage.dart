import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/presentaion/pages/message_page.dart/bchatpages/ChatBubble.dart';


class MesagesPage extends StatelessWidget {

  
  const MesagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
       appBar: AppBar(backgroundColor: black,
  centerTitle: true, 
  leading: IconButton(
    icon: const Icon(CupertinoIcons.back,
        color: Colors.black), // Back arrow icon
    onPressed: () {
      Navigator.pop(context); // Action to go back
    },
  ),
  title: ShaderMask(
    shaderCallback: (Rect bounds) {
      return const LinearGradient(
        colors: <Color>[Colors.green, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds);
    },
    child: const Text(
      'Klikers',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white, 
      ),
    ),
  ),
),body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          ChatBubble(
            isMe: false,
            message: 'Hello! How are you?',
            time: '10:30 AM',
            userImage: 'https://via.placeholder.com/150', 
          ),
          ChatBubble(
            isMe: true,
            message: 'I am good, thank you! How about you?',
            time: '10:32 AM',
            userImage: 'https://via.placeholder.com/150', 
          ),
          ChatBubble(
            isMe: false,
            message: 'I am doing well!',
            time: '10:35 AM',
            userImage: 'https://via.placeholder.com/150', )
        ],
      ),
    );
  }
}
