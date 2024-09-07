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
import 'package:klik/presentaion/pages/profile_page/my_post_delete_edit/my_post_page.dart';

import 'package:klik/presentaion/pages/profile_page/profilesession_pages/screen_edit_profile.dart';
import 'package:klik/presentaion/pages/profile_page/screen_settings/screen_settings.dart';

import 'package:klik/presentaion/pages/profile_page/simmer_widget.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/main_sessions.dart';
import 'package:page_transition/page_transition.dart';

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

class ScreenProfile extends StatefulWidget {
  final String profileImage = 'https://example.com/path/to/profile_image.jpg';
  final String coverImage = 'https://example.com/path/to/cover_image.jpg';

  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

int? index;

class _ScreenProfileState extends State<ScreenProfile> {
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
    final Size media = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BlocBuilder<LoginUserDetailsBloc, LoginUserDetailsState>(
              builder: (context, state) {
                if (state is LoginUserDetailsDataFetchSuccessState) {
                  return PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: CustomAppBar(
                      title: "Profile",
                      startColor: green,
                      backgroundColor: black,
                      endColor: blue,
                      actions: [
                        IconButton(
                          icon: const Icon(CupertinoIcons.ellipsis_vertical),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeftJoined,
                                childCurrent: widget,
                                duration: Duration(milliseconds: 400),
                                child: ScreenSettings(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: CustomAppBar(
                      title: 'Profile...',
                      startColor: green,
                      backgroundColor: black,
                      endColor: blue,
                      actions: [],
                    ),
                  );
                }
              },
            ),
          ),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: DefaultTabController(
              length: 2,
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
                                      builder: (context) => MyPostsScreen(
                                        index: 0,
                                        post: (context
                                                    .read<FetchMyPostBloc>()
                                                    .state
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
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (ctx) => ScreenFollowers(
                                  //       model: (context
                                  //               .read<FetchFollowersBloc>()
                                  //               .state as FetchFollowersSuccesState)
                                  //           .followersModel,
                                  //     ),
                                  //   ),
                                  // );
                                }
                              },
                              onFollowingTap: () {
                                if (context.read<FetchFollowingBloc>().state
                                    is FetchFollowingSuccesState) {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (ctx) => const ScreenFollowing(),
                                  //   ),
                                  // );
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
        ));
  }
}
