import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomeAppbar.dart';
import 'package:klik/domain/model/login_user_details_model.dart';
import 'package:klik/presentaion/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/login_user_details/login_user_details_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/screen_settings.dart';

String logginedUserProfileImage = '';
String profilepageUserId = '';
String profileuserName = '';
String coverImageUrl = '';
LoginUserModel userdetails = LoginUserModel(
    id: '',
    userName: '',
    email: '',
    phone: '',
    online: true,
    blocked: false,
    verified: false,
    role: '',
    isPrivate: false,
    createdAt: DateTime(20242024 - 06 - 24),
    updatedAt: DateTime(20242024 - 06 - 24),
    profilePic: '',
    backGroundImage: '');

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
    context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
    context.read<FetchFollowersBloc>().add(OnfetchAllFollowersEvent());
    context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Profile',
          startColor: green,
          endColor: blue,
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.ellipsis_vertical),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenSettings(),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: SafeArea(

          child:DefaultTabController(length: 2,
         child: BlocBuilder<LoginUserDetailsBloc, LoginUserDetailsState>(
            builder: (context, state) {
              if (state is LoginUserDetailsDataFetchSuccessState) {
                profileuserName =
                    state.userModel.name ?? state.userModel.userName;
                logginedUserProfileImage = state.userModel.profilePic;
                profilepageUserId = state.userModel.id;
                userdetails = state.userModel;
                coverImageUrl = state.userModel.backGroundImage;

                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: ProfileSession1(
                          media: media,
                          profileImage: logginedUserProfileImage,
                          coverImage: coverImageUrl,
                          userName: profileuserName,
                          bio: state.userModel.bio ?? '',
                          onEditProfile: () {
                            Navigator.of(context).push(  
                              MaterialPageRoute(
                                builder: (ctx) => ScreenEditProfile(
                                  cvImage: coverImageUrl,
                                  prImage: logginedUserProfileImage,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ProfileSession2(
                          onPostsTap: () {
                            if (context.read<FetchMyPostBloc>().state
                                is FetchMyPostSuccesState) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ScreenMyPost(
                                    index: 0,
                                    post: (context.read<FetchMyPostBloc>().state
                                            as FetchMyPostSuccesState)
                                        .posts,
                                  ),
                                ),
                              );
                            }
                          },
                          onFollowersTap: () {
                            if (context.read<FetchFollowersBloc>().state
                                is FetchFollowersSuccesState) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => ScreenFollowers(
                                    model: (context
                                            .read<FetchFollowersBloc>()
                                            .state as FetchFollowersSuccesState)
                                        .followersModel,
                                  ),
                                ),
                              );
                            }
                          },
                          onFollowingTap: () {
                            if (context.read<FetchFollowingBloc>().state
                                is FetchFollowingSuccesState) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const ScreenFollowing(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ];
                  },
                  body: const ProfileSession3(),
                );
              } else if (state is LoginUserDetailsDataFetchLoadingState) {
                return profileImageShimmerContainer(context);
              } else {
                return const Center(child: Text('Failed to load profile'));
              }
            },
          ),
        ),
      ),
    );
  }
}



//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         appBar: CustomAppBar(title: "username", backgroundColor: Colors.black),
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           child: Column(
//             children: [
//             Container(
//   padding: EdgeInsets.only(bottom: 25),
//   child: Stack(
//     clipBehavior: Clip.none, children: [
//       Container(
//         color: Colors.green,
//         width: double.infinity,
//         height: 250,
//       ),
//       Positioned(
//         bottom: 0, // position at the bottom of the container
//         left: 20,
//         child: Container(
//           width: 150,
//           height: 250,
//           child: OverflowBox(
//             maxWidth: 150,
//             maxHeight: 250,
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.red,
//                 border: Border.all(width: 2, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// class ProfilePage extends StatelessWidget {
//   final String profileImage =
//       'https://example.com/path/to/profile_image.jpg'; // Replace with your profile image URL
//   final String coverImage =
//       'https://example.com/path/to/cover_image.jpg';

//   const ProfilePage({super.key}); // Replace with your cover image URL

//   @override
//   Widget build(BuildContext context) {
//     final Size media = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Page'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             profileContainer(media, profileImage, coverImage),
//             SizedBox(height: 80), // Adjust height to account for profile picture overflow
//             // Add other widgets or content for the profile page here
//           ],
//         ),
//       ),
//     );
//   }

//   Widget profileContainer(Size media, String profileImage, String coverImage) {
//     return Container(
//       height: 210,
//       width: media.width,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         image: DecorationImage(
//           image: CachedNetworkImageProvider(coverImage),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             bottom: -60,
//             left: 20,
//             child: Container(
//               height: 120, // Adjusted height to fit within the screen
//               width: 120, // Adjusted width to fit within the screen
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(width: 5, color: Colors.white),
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               child: CachedNetworkImage(
//                 imageUrl: profileImage,
//                 imageBuilder: (context, imageProvider) => Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: BorderRadius.circular(100),
//                   ),
//                 ),
//                 placeholder: (context, url) => Shimmer.fromColors(
//                   baseColor: Colors.grey[300]!,
//                   highlightColor: Colors.grey[100]!,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
