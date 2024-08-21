
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:klik/application/core/constants/constants.dart';
// import 'package:klik/application/core/widgets/custome_snackbar.dart';
// import 'package:klik/presentaion/bloc/edit_user_profile_bloc/edit_user_profile_bloc.dart';
// import 'dart:io';

// import 'package:klik/presentaion/bloc/login_user_details/login_user_details_bloc.dart';

// class ScreenEditProfile extends StatefulWidget {
//   const ScreenEditProfile(
//       {super.key, required this.cvImage, required this.prImage});
//   final String cvImage;
//   final String prImage;
//   @override
//   State<ScreenEditProfile> createState() => _ScreenEditProfileState();
// }

// class _ScreenEditProfileState extends State<ScreenEditProfile> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController bioController = TextEditingController();
//   final ValueNotifier<String> profileImageNotifier = ValueNotifier('');
//   final ValueNotifier<String> coverImageNotifier = ValueNotifier('');

//   String profileImageUrl = '';
//   String coverImageUrl = '';
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   _ScreenEditProfileState();

//   @override
//   void initState() {
//     super.initState();
//     context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Edit Profile',
//           style: appBarTitleStyle,
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//       ),
//       body: BlocConsumer<LoginUserDetailsBloc, LoginUserDetailsState>(
//         listener: (context, state) {
//           if (state is LoginUserDetailsDataFetchSuccessState) {
//             nameController.text = state.userModel.userName;
//             bioController.text = state.userModel.bio ?? '';
//             profileImageUrl = state.userModel.profilePic;
//             coverImageUrl = state.userModel.backGroundImage;
//           }
//         },
//         builder: (context, userDetailsState) {
//           return BlocConsumer<EditUserProfileBloc, EditUserProfileState>(
//             listener: (context, state) {
//               if (state is EditUserProfileSuccesState) {
//                 customSnackbar(context, 'Profile details updated', green);
//                 context
//                     .read<LoginUserDetailsBloc>()
//                     .add(OnLoginedUserDataFetchEvent());
//                 Navigator.pop(context);
//               }
//             },
//             builder: (context, editProfileState) {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       ValueListenableBuilder<String>(
//                         valueListenable: coverImageNotifier,
//                         builder: (context, coverImagePath, child) {
//                           return Container(
//                             width: media.width,
//                             height: media.height * 0.25,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: coverImagePath.isNotEmpty
//                                     ? FileImage(File(coverImagePath))
//                                     : CachedNetworkImageProvider(widget.cvImage)
//                                         as ImageProvider,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             child: Stack(
//                               clipBehavior: Clip.none,
//                               children: [
//                                 Positioned(
//                                   bottom: -85,
//                                   left: 10,
//                                   child: ValueListenableBuilder<String>(
//                                     valueListenable: profileImageNotifier,
//                                     builder:
//                                         (context, profileImagePath, child) {
//                                       return GestureDetector(
//                                         onTap: () {
//                                           pickImage(profileImageNotifier);
//                                         },
//                                         child: Container(
//                                           height: 180,
//                                           width: 180,
//                                           decoration: BoxDecoration(
//                                             color: kwhiteColor,
//                                             border: Border.all(
//                                                 width: 5, color: kwhiteColor),
//                                             image: DecorationImage(
//                                               image: profileImagePath.isNotEmpty
//                                                   ? FileImage(
//                                                       File(profileImagePath))
//                                                   : CachedNetworkImageProvider(
//                                                           widget.prImage)
//                                                       as ImageProvider,
//                                               fit: BoxFit.cover,
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(100),
//                                           ),
//                                           child: Stack(
//                                             children: [
//                                               Positioned(
//                                                 right: 20,
//                                                 bottom: 10,
//                                                 child: CircleAvatar(
//                                                   radius: 25,
//                                                   backgroundColor: Colors.grey
//                                                       .withOpacity(0.7),
//                                                   child: const Icon(Icons.edit,
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 Positioned(
//                                   right: 10,
//                                   bottom: 10,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       pickImage(coverImageNotifier);
//                                     },
//                                     child: CircleAvatar(
//                                       radius: 25,
//                                       backgroundColor:
//                                           Colors.grey.withOpacity(0.7),
//                                       child: const Icon(Icons.edit,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       kheight100,
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             CustomTextField(
//                               hintText: 'Edit name',
//                               controller: nameController,
//                               validator: validateUsername,
//                             ),
//                             kheight20,
//                             CustomTextField(
//                               minlines: 3,
//                               maxlines: 5,
//                               hintText: 'Bio',
//                               controller: bioController,
//                               validator: validateBio,
//                             ),
//                             const SizedBox(height: 50),
//                             BlocBuilder<EditUserProfileBloc,
//                                 EditUserProfileState>(
//                               builder: (context, state) {
//                                 if (state is EditUserProfileLoadingState ||
//                                     state
//                                         is LoginUserDetailsDataFetchLoadingState) {
//                                   return loadingButton(
//                                       media: media,
//                                       onPressed: () {},
//                                       color: kPrimaryColor);
//                                 }
//                                 return customMaterialButton(
//                                   borderRadius: 20,
//                                   onPressed: () {
//                                     if (_formKey.currentState!.validate()) {
//                                       if (userDetailsState
//                                           is LoginUserDetailsDataFetchSuccesState) {
//                                         context.read<EditUserProfileBloc>().add(
//                                               OnEditProfileButtonClickedEvent(
//                                                   name: nameController.text,
//                                                   bio: bioController.text,
//                                                   image: profileImageNotifier
//                                                       .value,
//                                                   imageUrl: userDetailsState
//                                                       .userModel.profilePic,
//                                                   bgImage:
//                                                       coverImageNotifier.value,
//                                                   bgImageUrl: userDetailsState
//                                                       .userModel
//                                                       .backGroundImage),
//                                             );
//                                       }
//                                     }
//                                   },
//                                   text: 'Save',
//                                   color: kPrimaryColor,
//                                   width: media.width,
//                                   height: media.height * 0.05,
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
