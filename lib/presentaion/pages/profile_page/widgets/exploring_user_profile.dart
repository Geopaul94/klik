import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';
import 'package:klik/domain/model/explore_users_user_model.dart';
import 'package:klik/presentaion/bloc/profile_bloc/profile_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:klik/presentaion/bloc/follow_unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:klik/presentaion/bloc/login_user_details/login_user_details_bloc.dart';

import 'package:klik/presentaion/pages/profile_page/widgets/exploring_user_profilesections.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';

class ScreenExploreUserProfile extends StatefulWidget {
  final String userId;
  final UserIdSearchModel user;
  const ScreenExploreUserProfile(
      {super.key, required this.userId, required this.user});

  @override
  State<ScreenExploreUserProfile> createState() =>
      _ScreenExploreUserProfileState();
}

class _ScreenExploreUserProfileState extends State<ScreenExploreUserProfile> {
  String posts = '';
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchFollowingBloc>(context)
        .add(OnFetchFollowingUsersEvent());
    BlocProvider.of<ProfileBloc>(context)
        .add(ProfileInitialPostFetchEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomeAppbarRow(
        height: media.height,
        width: media.width,
        title: ' ',
        onBackButtonPressed: () => Navigator.pop(context),
        gradientColors: const [blue, green],
        backgroundColor: black,
        iconColor: Colors.white,
      ),
      body: SafeArea(
        child: MultiBlocBuilder(
          blocs: [
            context.watch<LoginUserDetailsBloc>(),
            context.watch<ProfileBloc>(),
            context.watch<FetchFollowingBloc>(),
            context.watch<UnfollowUserBloc>(),
        
          ],
          builder: (context, state) {
            var state2 = state[1];
            if (state2 is ProfilePostFetchSuccesfulState) {
              posts = state2.posts.length.toString();
            }

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                //     print(widget.user);
                return [
                  SliverToBoxAdapter(
                      child: ExploreUserProfileSession1(
                    media: media,
                    profileImage: widget.user.profilePic,
                    coverImage: widget.user.backGroundImage,
                    userName: widget.user.userName,
                    bio: widget.user.bio,
                    user: widget.user,
                    onEditProfile: () {},
                  )),
                  SliverToBoxAdapter(
                    child: ExploreUserProfileSessions2(
                      onPostsTap: () {},
                      onFollowersTap: () {},
                      onFollowingTap: () {},
                    ),
                  ),
                ];
              },
              body: const Column(
                children: [
                  kheight,
                  Text(
                    'Posts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  kheight,
                  Expanded(child: ExploreSession3()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
