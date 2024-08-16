

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_bloc.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_state.dart';
import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';

import 'package:lottie/lottie.dart';

// class AddPost extends StatefulWidget {
//   const AddPost({super.key});

//   @override
//   _AddPostState createState() => _AddPostState();
// }

// class _AddPostState extends State<AddPost> {
//   final TextEditingController _noteController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(size.height * 0.005),
//                   child: Column(
//                     children: [
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "New Post",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 25,
//                               color: Colors.white,
//                             ),
//                           ),  
//                         ],
//                       ),
//                       BlocConsumer<AddPostBloc, AddPostState>(
//                         listener: (context, state) {
//                           if (state is ImagePickedErrorState) {
//                             customSnackbar(context, state.error, red);
//                           } else if (state is ImageUploadErrorState) {
//                             customSnackbar(context, state.error, red);
//                           } else if (state is ImageUploadedState) {
//                             customSnackbar(
//                                 context, "Image uploaded successfully!", green);
//                             _noteController.clear();
//                             BlocProvider.of<AddPostBloc>(context)
//                                 .add(ClearImage());
//                             // Navigate to the profile page
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ProfilePage()),
//                             );
//                             // Fetch all posts after successful upload
//                             context
//                                 .read<FetchMyPostBloc>()
//                                 .add(FetchAllMyPostsEvent());
//                           }
//                         },
//                         builder: (context, state) {
//                           return Column(
//                             children: [
//                               if (state is ImagePickedLoadingState)
//                                 const Center(child: CircularProgressIndicator())
//                               else if (state is ImagePickedSuccessState)
//                                 AddPhotoContainer(
//                                   imageFile: state.imageFile,
//                                   onRemove: () {
//                                     BlocProvider.of<AddPostBloc>(context)
//                                         .add(RemoveImage());
//                                   },
//                                 )
//                               else
//                                 const AddPhotoContainer(),
//                               SizedBox(height: size.height * 0.02),
//                               TextFormField(
//                                 controller: _noteController,
//                                 decoration: const InputDecoration(
//                                   labelText: 'Add Description....',
//                                   labelStyle: TextStyle(color: grey),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(color: grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(color: green),
//                                   ),
//                                 ),
//                                 style: const TextStyle(color: Colors.white),
//                                 maxLines: 3,
//                               ),
//                               SizedBox(height: size.height * 0.02),
//                               BlocBuilder<AddPostBloc, AddPostState>(
//                                 builder: (context, state) {
//                                   if (state is ImageUploadingState) {
//                                     return loadingButton(
//                                       media: size,
//                                       onPressed: () {},
//                                       gradientStartColor: green,
//                                       loadingIndicatorColor: purple,
//                                       gradientEndColor: blue,
//                                     );
//                                   }
//                                   return CustomElevatedButton(
//                                     onPressed: () async {
//                                       if (_noteController.text.trim().length >=
//                                               4 &&
//                                           state is ImagePickedSuccessState) {
//                                         BlocProvider.of<AddPostBloc>(context)
//                                             .add(
//                                           OnPostButtonClickedEvent(
//                                               note: _noteController.text,
//                                               imagePath: state.imageFile.path),
//                                         );
//                                         context
//                                             .read<FetchMyPostBloc>()
//                                             .add(FetchAllMyPostsEvent());
//                                       } else {
//                                         customSnackbar(
//                                             context,
//                                             'Please provide a description with at least 4 characters and an image.',
//                                             red);
//                                       }
//                                     },
//                                     text: "Post",
//                                   );
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddPhotoContainer extends StatelessWidget {
//   final XFile? imageFile;
//   final VoidCallback? onRemove;

//   const AddPhotoContainer({this.imageFile, this.onRemove, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.35,
//       color: darkgreymain,
//       width: size.width * 0.9,
//       child: Stack(
//         children: [
//           if (imageFile != null)
//             Center(
//               child: Image.file(
//                 File(imageFile!.path),
//                 fit: BoxFit.cover,
//                 width: size.width * 0.9,
//                 height: size.height * 0.35,
//               ),
//             )
//           else
//             GestureDetector(
//               onTap: () {
//                 BlocProvider.of<AddPostBloc>(context)
//                     .add(PickImageFromGallery());
//               },
//               child: Container(
//                 height: size.height * 0.35,
//                 color: darkgreymain,
//                 width: size.width * 0.7,
//                 child: const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       CupertinoIcons.photo,
//                       color: Colors.grey,
//                       size: 50,
//                     ),
//                     SizedBox(height: 5), // Replaced h5 with SizedBox
//                     Text(
//                       'Add Image....',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           Positioned(
//             bottom: 10,
//             right: 10,
//             child: imageFile == null
//                 ? GestureDetector(
//                     onTap: () {
//                       BlocProvider.of<AddPostBloc>(context).add(CaptureImage());
//                     },
//                     child: SizedBox(
//                       height: 50,
//                       width: 50,
//                       child: Lottie.asset(
//                         'assets/animations/camera_klik.json',
//                       ),
//                     ),
//                   )
//                 : GestureDetector(
//                     onTap: onRemove,
//                     child: const Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                       size: 30,
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_bloc.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_state.dart';
import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
import 'package:lottie/lottie.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.height * 0.005),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "New Post",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      BlocConsumer<AddPostBloc, AddPostState>(
                        listener: (context, state) {
                          if (state is ImagePickedErrorState) {
                            customSnackbar(context, state.error, red);
                          } else if (state is ImageUploadErrorState) {
                            customSnackbar(context, state.error, red);
                          } else if (state is ImageUploadedState) {
                            customSnackbar(
                                context, "Image uploaded successfully!", green);
                            _noteController.clear();
                            BlocProvider.of<AddPostBloc>(context)
                                .add(ClearImage());
                            // Navigate to the profile page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );
                            // Fetch all posts after successful upload
                            context
                                .read<FetchMyPostBloc>()
                                .add(FetchAllMyPostsEvent());
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              if (state is ImagePickedLoadingState)
                                const Center(child: CircularProgressIndicator())
                              else if (state is ImagePickedSuccessState)
                                AddPhotoContainer(
                                  imageFile: state.imageFile,
                                  onRemove: () {
                                    BlocProvider.of<AddPostBloc>(context)
                                        .add(RemoveImage());
                                  },
                                )
                              else
                                const AddPhotoContainer(),
                              SizedBox(height: size.height * 0.02),
                              TextFormField(
                                controller: _noteController,
                                decoration: const InputDecoration(
                                  labelText: 'Add Description....',
                                  labelStyle: TextStyle(color: grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: green),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                maxLines: 3,
                              ),
                              SizedBox(height: size.height * 0.02),
                              BlocBuilder<AddPostBloc, AddPostState>(
                                builder: (context, state) {
                                  if (state is ImageUploadingState) {
                                    return loadingButton(
                                      media: size,
                                      onPressed: () {},
                                      gradientStartColor: green,
                                      loadingIndicatorColor: purple,
                                      gradientEndColor: blue,
                                    );
                                  }
                                  return CustomElevatedButton(
                                    onPressed: () async {
                                      if (_noteController.text.trim().length >=
                                              4 &&
                                          state is ImagePickedSuccessState) {
                                        BlocProvider.of<AddPostBloc>(context)
                                            .add(
                                          OnPostButtonClickedEvent(
                                              note: _noteController.text,
                                              imagePath:
                                                  state.imageFile.path),
                                        );
                                      } else {
                                        customSnackbar(
                                            context,
                                            'Please provide a description with at least 4 characters and an image.',
                                            red);
                                      }
                                    },
                                    text: "Post",
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddPhotoContainer extends StatelessWidget {
  final XFile? imageFile;
  final VoidCallback? onRemove;

  const AddPhotoContainer({this.imageFile, this.onRemove, super.key});

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
                    SizedBox(height: 5), // Replaced h5 with SizedBox
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
