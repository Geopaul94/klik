import 'package:flutter/material.dart';

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  const ImageDetailPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Detail')),
      body: Center(
        child: Image.network(imageUrl), // Display the passed image
      ),
    );
  }
}
