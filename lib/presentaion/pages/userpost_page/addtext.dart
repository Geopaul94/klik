import 'package:flutter/material.dart';

Widget noteWithPhotoField({
  required TextEditingController noteController,
  required void Function() onAddPhoto,
  String hintText = 'Enter your notes here...',
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        controller: noteController,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 10),
      Row(
        children: [
          ElevatedButton(
            onPressed: onAddPhoto,
            child: Row(
              children: [
                Icon(Icons.photo_camera),
                SizedBox(width: 5),
                Text('Add Photo'),
              ],
            ),
          ),
          // You can add a preview of the photo if needed
        ],
      ),
    ],
  );
}
