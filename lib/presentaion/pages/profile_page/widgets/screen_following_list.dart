import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/show_dialogue.dart';
import 'package:klik/domain/model/explore_users_user_model.dart';

import 'package:klik/presentaion/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:klik/presentaion/bloc/follow_unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/CustomeListTile.dart';
import 'package:klik/presentaion/pages/profile_page/simmer_widget.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/exploring_user_profile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



class FollowingList extends StatelessWidget {
  const FollowingList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomeAppbarRow(
        height: size.height,
        width: size.width,
        title: 'Following List',
        onBackButtonPressed: () => Navigator.pop(context),
        gradientColors: const [blue, green],
        backgroundColor: black,
        iconColor: Colors.white,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FetchFollowingBloc, FetchFollowingState>(
            listener: (context, state) {
              if (state is FetchFollowingErrorState) {
                customSnackbar(context, 'Failed..!', amber);
              }
            },
          ),
          BlocListener<UnfollowUserBloc, UnfollowUserState>(
            listener: (context, state) {
              if (state is UnfollowUserSuccesState) {
                context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
              } else if (state is UnfollowUserErroState) {
              
              }
            },
          ),
        ],
        child: BlocBuilder<FetchFollowingBloc, FetchFollowingState>(
          builder: (context, state) {
            if (state is FetchFollowingLoadingState || state is UnfollowUserLoadingState) {
              return ListView.builder(
                itemBuilder: (context, index) => shimmerTile(),
                itemCount: 5,
              );
            } else if (state is FetchFollowingSuccesState) {
              final followings = state.model.following;

              if (followings.isEmpty) {
                return const Center(
                  child: Text('No followers yet.'),
                );
              }

           return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 4,),
                itemBuilder: (context, index) => SizedBox(
                  height: 68,
                  child: Container(color: black,
                  padding: const EdgeInsets.all(8),
                    child: CustomListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenExploreUserProfile(
                                    userId: state.model.following[index].id,
                                    user: UserIdSearchModel(
                                        id: state.model.following[index].id,
                                        userName:
                                            state.model.following[index].userName,
                                        email: state.model.following[index].email,
                                        profilePic: state
                                            .model.following[index].profilePic,
                                        online:
                                            state.model.following[index].online,
                                        blocked:
                                            state.model.following[index].blocked,
                                        verified:
                                            state.model.following[index].verified,
                                        role: state.model.following[index].role,
                                        isPrivate: state
                                            .model.following[index].isPrivate,
                                        backGroundImage: state.model
                                            .following[index].backGroundImage,
                                        createdAt: DateTime.parse(state
                                            .model.following[index].createdAt),
                                        updatedAt: DateTime.parse(state
                                            .model.following[index].updatedAt),
                                        v: state.model.following[index].v,
                                        bio: state.model.following[index].bio ??
                                            '')),
                              ));
                        },
                    
                    
                    
                    
                    
                        buttonText: 'unfollow',
                        profileImageUrl: followings[index].profilePic,
                        titleText: followings[index].userName,
                        onUnfollow: () {
                          showConfirmationDialog(
                            context: context,
                            title: "Are you sure?",
                            content: "Unfollow this user?",
                            confirmButtonText: 'Unfollow',
                            cancelButtonText: 'Cancel',
                            onConfirm: () async {
                              context.read<UnfollowUserBloc>().add(
                                  UnFollowUserButtonClickEvent(
                                       followersId:  followings[index].id,));
                            },
                          );
                        },
                        imageSize: media.height * 0.05,
                        backgroundColor: kwhiteColor,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                itemCount: followings.length,
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: kPrimaryColor,
                  size: 30,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
