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
  void initState() {
    super.initState();
    fetchAndLogApiResponse(1, 5);
  }

  Future<void> fetchAndLogApiResponse(int page, int pageSize) async {
    try {
      final token = await getUsertoken();
      final response = await http.get(
        Uri.parse(
          '${Apiurl.baseUrl}${Apiurl.allFollowingsPost}?page=$page&pageSize=$pageSize',
        ),
        headers: {
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        log('Response Body: ${response.body}');
        final jsonResponse = json.decode(response.body);

        if (jsonResponse is List) {
          if (jsonResponse.isEmpty) {
            log('Received an empty list from the API.');
          } else {
            // Handle the list data
            for (var item in jsonResponse) {
              log('Item: $item');
            }
          }
        } else {
          log('Unexpected response format: ${jsonResponse.runtimeType}');
        }
      } else {
        log('Failed to load data with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Response Logger'),
      ),
      body: Center(
        child: Text('Check the console for the API response'),
      ),
    );
  }
}
