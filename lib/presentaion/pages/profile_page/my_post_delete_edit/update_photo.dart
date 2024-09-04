
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_bloc.dart';
import 'package:lottie/lottie.dart';

class UpdatePhotoContainer extends StatelessWidget {
  final XFile? imageFile;
  final VoidCallback? onRemove;

  const UpdatePhotoContainer({this.imageFile, this.onRemove, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35,
      color: darkgreymain,
      width: size.width * 0.9,
      child: Stack(
        children: [
          if (imageFile != null)
            Center(
              child: Image.file(
                File(imageFile!.path),
                fit: BoxFit.cover,
                width: size.width * 0.9,
                height: size.height * 0.35,
              ),
            )
          else
            GestureDetector(
              onTap: () {
                BlocProvider.of<AddPostBloc>(context)
                    .add(PickImageFromGallery());
              },
              child: Container(
                height: size.height * 0.35,
                color: darkgreymain,
                width: size.width * 0.7,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.photo,
                      color: Colors.grey,
                      size: 50,
                    ),
                    SizedBox(height: 5), 
                    Text(
                      'Add Image....',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 10,
            right: 10,
            child: imageFile == null
                ? GestureDetector(
                    onTap: () {
                      BlocProvider.of<AddPostBloc>(context).add(CaptureImage());
                    },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Lottie.asset(
                        'assets/animations/camera_klik.json',
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: onRemove,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}












