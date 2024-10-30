import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  const ImageDetailPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) { final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
     appBar: CustomeAppbarRow(
        height: height,
        width: width,
        title: 'Explore',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Container(height: height*0.8,
        width: width*.8,  

      decoration:   
  BoxDecoration(
 border: Border.all(
                color: Colors.green,
                width: 1,
              ),   borderRadius: BorderRadius.circular(15),
             
),

          child: InteractiveViewer(
            maxScale: 5.0,
            minScale: .01,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            child: Image.network(imageUrl))), 
      ),
    );
  }
}
