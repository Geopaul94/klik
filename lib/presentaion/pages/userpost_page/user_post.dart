// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:klik/application/core/constants/constants.dart';
// import 'package:klik/application/core/widgets/CustomElevatedButton.dart';

// import 'package:klik/application/core/widgets/CustomeAppbar.dart';
// import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
// import 'package:klik/presentaion/pages/userpost_page/addphoto.dart';
// import 'package:klik/presentaion/pages/userpost_page/addtext.dart';

// class UserPost extends StatelessWidget {
//    UserPost({super.key}) {
//      // TODO: implement UserPost
//      throw UnimplementedError();
//    }

//  final TextEditingController noteController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     var width = size.width;
//     var height = size.height;
//     return Scaffold(
//         backgroundColor: black,
//         body: SafeArea(
//             child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(size.height * .005),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomeLinearcolor(
//                           text: "New Post",
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25,
//                         ),
//                         CustomeLinearcolor(
//                           text: "Camera",
//                           fontWeight: FontWeight.bold,
//                           fontSize: 26,
//                           gradientColors: const [blue, green],
//                           iconData: Icons.camera_alt,
//                           iconSize: 24,
//                           iconGradientColors: const [blue, green],
//                         ),
//                       ],
//                     ),

//                        addPhotoContainer(context),

//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )));
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/presentaion/bloc/userpost/user_post_bloc.dart';
import 'package:lottie/lottie.dart';

class UserPost extends StatelessWidget {
  const UserPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "New Post",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          color: Colors.white,
                          onPressed: () {
                            BlocProvider.of<UserPostBloc>(context)
                                .add(CaptureImage());
                          },
                        ),
                      ],
                    ),
                    BlocConsumer<UserPostBloc, UserPostState>(
                      listener: (context, state) {
                        if (state is ImagePickedErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        } else if (state is ImageUploadError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        } else if (state is ImageUploaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Image uploaded successfully!')),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ImagePickedLoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is ImagePickedSuccessState) {
                          return Column(
                            children: [
                              Image.file(File(state.imageFile.path)),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Note',
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                maxLines: 3,
                                onFieldSubmitted: (note) {
                                  BlocProvider.of<UserPostBloc>(context).add(
                                    UploadImage(
                                        note: note, imageFile: state.imageFile),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              IconButton(
                                icon: const Icon(CupertinoIcons.photo),
                                color: Colors.grey,
                                onPressed: () {
                                  BlocProvider.of<UserPostBloc>(context)
                                      .add(PickImageFromGallery());
                                },
                              ),
                              const Text(
                                'Add Image....',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const AddPhotoContainer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPhotoContainer extends StatelessWidget {
  const AddPhotoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
 

    return Container(
      height: size.height * 0.35,
      color: darkgreymain,
      width: size.width * 0.9,
      child: Stack(
        children: [
           Center(
            child: GestureDetector(onTap: () {
                BlocProvider.of<UserPostBloc>(context).add(PickImageFromGallery());
              },
              child: Container( height: size.height * 0.35,
              color: green,width:  size.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.photo,
                      color: Colors.grey,
                      size: 50,
                    ),
                    Text(
                      'Add Image....',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<UserPostBloc>(context).add(CaptureImage());
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: Lottie.asset(
                  'assets/animations/camera_klik.json',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
