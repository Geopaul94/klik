
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customMaterialButton.dart';
import 'package:klik/presentaion/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/profile_succes_dummy_container.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/repeated_column.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/saved_and_post_grid.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/user_and_bio_tile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileSession1 extends StatelessWidget {
  final Size media;
  final String profileImage;
  final String coverImage;
  final String userName;
  final String bio;
  final VoidCallback onEditProfile;

  const ProfileSession1({
    required this.media,
    required this.profileImage,
    required this.coverImage,
    required this.userName,
    required this.bio,
    required this.onEditProfile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profileContainer(media, profileImage, coverImage),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: customMaterialButton(
                  color: kPrimaryColor,
                  onPressed: onEditProfile,
                  text: 'Edit Profile',
                  width: media.height * 0.12,
                  height: media.height * 0.05,
                  textStyle: const TextStyle(fontSize: 16),
                  borderRadius: 20),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: userNameAndBio(userName, bio),
        ),
      ],
    );
  }
}

class ProfileSession2 extends StatelessWidget {
  final VoidCallback onPostsTap;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;

  const ProfileSession2({
    required this.onPostsTap,
    required this.onFollowersTap,
    required this.onFollowingTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
            builder: (context, state) {
              return state is FetchMyPostSuccesState
                  ? customTextColumn(
                      text1: state.posts.length.toString(),
                      text2: 'Posts',
                      textStyle: profilecolumnStyle,
                      onTap: onPostsTap,
                    )
                  : customTextColumn(
                      text1: '',
                      text2: 'Posts',
                      textStyle: profilecolumnStyle,
                      onTap: () {});
            },
          ),
          BlocBuilder<FetchFollowersBloc, FetchfollowersState>(
            builder: (context, state) {
              return state is FetchFollowersSuccesState
                  ? customTextColumn(
                      text1: state.followersModel.followers.length.toString(),
                      text2: 'Followers',
                      textStyle: profilecolumnStyle,
                      onTap: onFollowersTap,
                    )
                  : customTextColumn(
                      text1: '',
                      text2: 'Followers',
                      textStyle: profilecolumnStyle,
                      onTap: onFollowersTap,
                    );
            },
          ),
          BlocBuilder<FetchFollowingBloc, FetchFollowingState>(
            builder: (context, state) {
              return state is FetchFollowingSuccesState
                  ? customTextColumn(
                      text1: state.model.following.length.toString(),
                      text2: 'Following',
                      textStyle: profilecolumnStyle,
                      onTap: onFollowingTap,
                    )
                  : customTextColumn(
                      text1: '',
                      text2: 'Following',
                      textStyle: profilecolumnStyle,
                      onTap: onFollowingTap,
                    );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileSession3 extends StatelessWidget {
  const ProfileSession3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TabBar(
            labelColor: oceanGreen,
            unselectedLabelColor: grey,
            indicatorColor: oceanGreen,
            tabs: [
              Tab(text: 'My Posts'),
              Tab(text: 'Saved Posts'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
                builder: (context, state) {
                  if (state is FetchMyPostSuccesState) {
                    return MyPostsGrid(post: state.posts);
                  } else if (state is FetchMyPostLoadingState) {
                    return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: kPrimaryColor,
                        size: 30,
                      ),
                    );
                  } else {
                    return const Center(child: Text('No posts available'));
                  }
                },
              ),
              const SavedPostsGrid(),
            ],
          ),
        ),
      ],
    );
  }
}
