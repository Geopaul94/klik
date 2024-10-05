import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';
import 'package:klik/domain/model/explore_users_user_model.dart';
import 'package:klik/domain/model/following_model.dart';
import 'package:klik/main.dart';
import 'package:klik/presentaion/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:klik/presentaion/bloc/follow_unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:klik/presentaion/bloc/get_connections_bloc/get_connections_bloc.dart';
import 'package:klik/presentaion/bloc/profile_bloc/profile_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/evo/screen_other_users_post.dart';

class UserProfileScreen extends StatefulWidget {


  final String userId;
 
  final UserIdSearchModel user;


  const UserProfileScreen({super.key, required this.userId,required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();



  
}

class _UserProfileScreenState extends State<UserProfileScreen> {

   List  followings = [];


@override
  void initState() {
    // TODO: implement initState
    super.initState();


context.read<ProfileBloc>().add(ProfileInitialPostFetchEvent(userId: widget.userId));


 context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
    context
        .read<GetConnectionsBloc>()
        .add(ConnectionsInitilFetchEvent(userId: widget.userId));






  }

  @override
  Widget build(BuildContext context) { final Size size = MediaQuery.of(context).size;

     final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return  Scaffold(appBar:  CustomeAppbarRow(
        height: height,
        width: width,
        title: "Explore",
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        searchIcon: true,
        gradientColors: const [Colors.blue, Colors.green]
    ),


    body: SizedBox(


      height: size.height,
          width: size.width,



           child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 210,
                width: size.width,
                decoration: BoxDecoration(
                    color: green,
                    image: DecorationImage(
                        image: NetworkImage(widget.user.backGroundImage),
                        fit: BoxFit.cover)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(child: CircularProgressIndicator()),
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: widget.user.backGroundImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),

Positioned(
                      bottom: -60,
                      left: 20,
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 5,
                               
                                     
                                  
                               color     : darkgreymain),
                            borderRadius: BorderRadius.circular(100)),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => ImageDialogue(
                                      image: widget.user.profilePic,
                                    ));
                          },
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: widget.user.profilePic,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return CircularProgressIndicator();
                              },
                            ),
                          ),
                        ),
                      ),





 ),
                  ],
                ),
              ),
              h40,
              h30,





 Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  widget.user.name != null
                      ? widget.user.name.toString()
                      : 'Guest User',
                  style: profilestyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  widget.user.bio != null ? widget.user.bio.toString() : '',
                  style: profilestyle2,
                ),
              ),



  h20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ProfilePostFetchSuccesfulState) {
                        return Column(
                          children: [
                            Text(
                              state.posts.length.toString(),
                              style: profilestyle,
                            ),
                            Text(state.posts.length < 2 ? 'Post' : 'Posts',
                                style: profilestyle2)
                          ],
                        );
                      }


 return const Column(
                        children: [
                          Text(
                            '0',
                            style: profilestyle,
                          ),
                          Text('Post', style: profilestyle2)
                        ],
                      );
                    },
                  ),


 BlocConsumer<GetConnectionsBloc, GetConnectionsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetConnectionsSuccesfulState) {
                        return Column(
                          children: [
                            Text(
                              state.followersCount.toString(),
                              style: profilestyle,
                            ),
                            Text(
                                state.followersCount < 2
                                    ? 'Follower'
                                    : 'Followers',
                                style: profilestyle2),
                          ],
                        );
                      }
                      return const Column(
                        children: [
                          Text(
                            '0',
                            style: profilestyle,
                          ),
                          Text('Followers', style: profilestyle2),
                        ],
                      );
                    },
                  ),


    BlocConsumer<GetConnectionsBloc, GetConnectionsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetConnectionsSuccesfulState) {
                        return Column(
                          children: [
                            Text(
                              state.followingsCount.toString(),
                              style: profilestyle,
                            ),
                            Text(
                                state.followingsCount < 2
                                    ? 'Following'
                                    : 'Followings',
                                style: profilestyle2)
                          ],
                        );
                      }
                      return const Column(
                        children: [
                          Text(
                            '0',
                            style: profilestyle,
                          ),
                          Text('Following', style: profilestyle2),
                        ],
                      );
                    },
                  ),
                ],
              ),
 h30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<FetchFollowingBloc, FetchFollowingState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is FetchFollowingSuccesState) {
                        final FollowingsModel followingsModel =
                            state.model;
                        followings = followingsModel.following;
                      }
                      return GestureDetector(
                          onTap: () {
                            bool isFollowing = followings.any(
                                (following) => following.id == widget.userId);
                            if (isFollowing) {
                              followings.removeWhere(
                                  (element) => element.id == widget.userId);
                              context.read<UnfollowUserBloc>().add(
                                  UnFollowUserButtonClickEvent(
                                      followersId: widget.userId));
                              context
                                  .read<FetchFollowingBloc>()
                                  .add(OnFetchFollowingUsersEvent());
                              context.read<GetConnectionsBloc>().add(
                                  ConnectionsInitilFetchEvent(
                                      userId: widget.userId));
                            }

 else {
                              followings.add(Follower(
                                  id: widget.userId,
                                  userName: widget.user.userName,
                                  email: widget.user.email,
                                  password: widget.user.password ?? '',
                                  phone: widget.user.phone,
                                  online: widget.user.online,
                                  blocked: widget.user.blocked,
                                  verified: widget.user.verified,
                                  role: widget.user.role,
                                  isPrivate: widget.user.isPrivate,
                                  createdAt: widget.user.createdAt.toString(),
                                  updatedAt: widget.user.updatedAt.toString(),
                                  v: widget.user.v,
                                  profilePic: widget.user.profilePic,
                                  backGroundImage:
                                      widget.user.backGroundImage));
                              context.read<UnfollowUserBloc>().add(
                                  FollowUserButtonClickEvent(
                                    followersId  : widget.userId));
                              context
                                  .read<FetchFollowingBloc>()
                                  .add(OnFetchFollowingUsersEvent());
                              context.read<GetConnectionsBloc>().add(
                                  ConnectionsInitilFetchEvent(
                                      userId: widget.userId));
                    }
                          },





child: CustomElevatedButton(text:   followings.any((following) =>
                                    following.id == widget.userId)
                                ? 'Unfollow'
                                : 'Follow',onPressed: () {
  
},

     width: .4,

));


  },
                  ),






              h30,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                      child: Icon(
                    Icons.grid_on_sharp,
                    size: 30,
                  )),
                  Text(
                    ' Posts',
                    style: profilestyle,
                  )
                ],
              ),
              h10,
              const Divider(
                thickness: 1,
                height: 1,
              ),
              h10,
              Flexible(
                flex: 0,
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfilePostFetchSuccesfulState) {
                      final posts = state.posts;

                      return posts.isEmpty
                          ? Center(
                              child: 
                                 Text("No Post available"),
                            )
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                  PostDetailsUserPage(
                    
                    
                    
                    
                    
                    
                    
               posts: state.posts,
                                            initialindex: index)
                    ));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    elevation: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2.0),
                                      child: Image.network(
                                        state.posts[index].image,
                                        fit: BoxFit.cover,
                                        width: 300,
                                        height: 200,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );




























                            
                    } else if (state is ProfilePostFetchLoadingState) {
                      return CircularProgressIndicator();
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              )
            ]),
          ]),
      )  ));
  }
}

      

class ImageDialogue extends StatelessWidget {
  final String image;
  const ImageDialogue({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      surfaceTintColor: black,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: CachedNetworkImageProvider(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}