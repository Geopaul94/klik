import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {

 
  


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('API Response Logger'),
    ),
    body: const Image(
      image: AssetImage('assets/internetcheckcrop(1).jpg'), 
      fit: BoxFit.cover, 
      height: double.infinity,
      width: double.infinity,
    ),
  );
}}
