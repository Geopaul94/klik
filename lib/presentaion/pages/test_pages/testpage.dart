import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:klik/application/core/url/url_.dart';
import 'dart:developer';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {

 
  


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('API Response Logger'),
    ),
    body: Image(
      image: AssetImage('assets/internetcheckcrop(1).jpg'), 
      fit: BoxFit.cover, 
      height: double.infinity,
      width: double.infinity,
    ),
  );
}}
