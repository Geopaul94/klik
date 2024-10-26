import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customMaterialButton.dart';
import 'package:klik/domain/model/explore_users_user_model.dart';
import 'package:klik/domain/model/following_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:klik/presentaion/bloc/fetchallconversation_bloc/fetch_all_conversations_bloc.dart';
import 'package:klik/presentaion/bloc/get_connections_bloc/get_connections_bloc.dart';
import 'package:klik/presentaion/bloc/profile_bloc/profile_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:klik/presentaion/bloc/follow_unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/message_page.dart/chat/chatscreen.dart';

import 'package:klik/presentaion/pages/profile_page/profile_session_pages.dart';
import 'package:klik/presentaion/pages/profile_page/profilesession_pages/profile_succes_dummy_container.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/loading_animation_and_error_idget.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/screen_other_users_post.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ExploreUserProfileSession1 extends StatelessWidget {
  final Size media;
  final String profileImage;
  final String coverImage;
  final String userName;
  final String bio;

  final UserIdSearchModel user;
  final VoidCallback onEditProfile;

  ExploreUserProfileSession1({
    super.key,
    required this.media,
    required this.profileImage,
    required this.coverImage,
    required this.userName,
    required this.bio,
    required this.user,
    required this.onEditProfile,
  });

  List<Follower> followings = [];

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
              padding: const EdgeInsets.only(right: 5),
              child: BlocBuilder<FetchFollowingBloc, FetchFollowingState>(
                builder: (context, state) {
                  if (state is FetchFollowingSuccesState) {
                    final FollowingsModel followingsModel = state.model;
                    followings = followingsModel.following;
                    return customMaterialButton(
                      borderRadius: 10,
                      color: green,
                      onPressed: () {
                        bool isFollowing = followings
                            .any((following) => following.id == user.id);
                        if (isFollowing) {
                          followings
                              .removeWhere((element) => element.id == user.id);
                          context.read<UnfollowUserBloc>().add(
                              UnFollowUserButtonClickEvent(
                                  followersId: user.id));
                          context
                              .read<FetchFollowingBloc>()
                              .add(OnFetchFollowingUsersEvent());
                        } else {
                          followings.add(Follower(
                              id: user.id,
                              userName: user.userName,
                              email: user.email,
                              password: user.password ?? '',
                              phone: user.phone,
                              online: user.online,
                              blocked: user.blocked,
                              verified: user.verified,
                              role: user.role,
                              isPrivate: user.isPrivate,
                              createdAt: formatDate(user.createdAt),
                              updatedAt: formatDate(user.updatedAt),
                              v: user.v,
                              profilePic: user.profilePic,
                              backGroundImage: user.backGroundImage));
                          context.read<UnfollowUserBloc>().add(
                              FollowUserButtonClickEvent(followersId: user.id));
                          context
                              .read<FetchFollowingBloc>()
                              .add(OnFetchFollowingUsersEvent());
                        }
                      },
                      text:
                          followings.any((following) => following.id == user.id)
                              ? 'Unfollow'
                              : 'Follow',
                      width: media.height * 0.09,
                      height: media.height * 0.05,
                      textStyle: const TextStyle(fontSize: 14),
                    );
                  } else {
                    return customMaterialButton(
                      borderRadius: 10,
                      color: green,
                      onPressed: onEditProfile,
                      text: '',
                      width: media.height * 0.09,
                      height: media.height * 0.04,
                      textStyle: const TextStyle(fontSize: 16),
                    );
                  }
                },
              ),
            ),
            BlocConsumer<ConversationBloc, ConversationState>(
              listener: (context, state) {
                if (state is ConversationSuccesfulState) {
                  context
                      .read<FetchAllConversationsBloc>()
                      .add(AllConversationsInitialFetchEvent());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            conversationId: state.conversationId,
                            recieverid: user.id,
                            name: user.userName,
                            profilepic: user.profilePic,
                            username: user.userName),
                      )
                      
                    
                      
                      );
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: customMaterialButton(
                    borderRadius: 10,
                    color: green,
                    onPressed: () {
                      context.read<ConversationBloc>().add(
                          CreateConversationButtonClickEvent(
                              members: [currentuserId, user.id]));
                    },
                    text: 'messsage',
                    width: media.height * 0.1,
                    height: media.height * 0.05,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                );
              },
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

class ExploreUserProfileSessions2 extends StatelessWidget {
  final VoidCallback onPostsTap;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;

  const ExploreUserProfileSessions2(
      {super.key,
      required this.onPostsTap,
      required this.onFollowersTap,
      required this.onFollowingTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfilePostFetchSuccesfulState) {
                return customTextColumn(
                    text1: state.posts.length.toString(),
                    text2: 'Posts',
                    textStyle: profilecolumnStyle,
                    onTap: () {});
              } else {
                return customTextColumn(
                    text1: '',
                    text2: 'Posts',
                    textStyle: profilecolumnStyle,
                    onTap: () {});
              }
            },
          ),
          BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
            builder: (context, state) {
              if (state is GetConnectionsSuccesfulState) {
                print(
                    'state.followersCount================${state.followersCount.toString()}');
                return customTextColumn(
                  text1: state.followersCount.toString(),
                  text2: 'Followers',
                  textStyle: profilecolumnStyle,
                  onTap: onFollowersTap,
                );
              } else {
                return customTextColumn(
                  text1: '0',
                  text2: 'Followers',
                  textStyle: profilecolumnStyle,
                  onTap: onFollowersTap,
                );
              }
            },
          ),
          BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
            builder: (context, state) {
              if (state is GetConnectionsSuccesfulState) {
                return customTextColumn(
                  text1: state.followingsCount.toString(),
                  text2: 'Following',
                  textStyle: profilecolumnStyle,
                  onTap: onFollowersTap,
                );
              } else {
                return customTextColumn(
                  text1: '0',
                  text2: 'Following',
                  textStyle: profilecolumnStyle,
                  onTap: onFollowersTap,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ExploreSession3 extends StatelessWidget {
  const ExploreSession3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfilePostFetchSuccesfulState) {
          if (state.posts.isNotEmpty) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScreenOtherUserPosts(posts: state.posts),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: CachedNetworkImage(
                        imageUrl: state.posts[index].image,
                        placeholder: (context, url) =>
                            LoadingAnimationWidget.fourRotatingDots(
                                color: grey, size: 30),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return errorStateWidget('No Posts ', greyMeduim);
          }
        } else {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: kPrimaryColor, size: 30),
          );
        }
      },
    );
  }
}
