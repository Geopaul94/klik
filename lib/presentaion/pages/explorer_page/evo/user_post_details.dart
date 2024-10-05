import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';
import 'package:klik/application/core/widgets/homepageshimmer.dart';
import 'package:klik/domain/model/explore_posts_model.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/presentaion/bloc/explorerposts_bloc/explorerpost_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/evo/postview.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';


class UsersPostDetailsList extends StatefulWidget {
  final int initialindex;
  const UsersPostDetailsList({
    super.key,
    required this.initialindex,
  });

  @override
  State<UsersPostDetailsList> createState() => _UsersPostDetailsListState();
}

class _UsersPostDetailsListState extends State<UsersPostDetailsList> {
  @override
  void initState() {
    super.initState();
    context.read<ExplorerpostBloc>().add(FetchExplorerPostsEvent());
  }

  List<ExplorePostModel> posts = [];
  List<SavedPostModel> savedPosts = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomeAppbarRow(
        height: height,
        width: width,
        title: 'Explore',
        onBackButtonPressed: () {},
      ),
      body: MultiBlocBuilder(
        blocs: [
          context.watch<ExplorerpostBloc>(),
          context.watch<FetchSavedPostsBloc>()
        ],
        builder: (context, state) {
       var state1 = state[0];
          var state2 = state[1];

          if (state2 is FetchSavedPostsSuccesfulState) {
            savedPosts = state2.posts;
          }

          if (state1 is ExplorerpostSuccesstate) {
         posts = state1.posts;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    controller: ScrollController(
                        initialScrollOffset: widget.initialindex == 0
                            ? 0
                            : widget.initialindex * 450),
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      return 
                      
                      
                      PostView(
                        v: post.userId.v,
                        online: post.userId.online,
                        verified: post.userId.verified,
                        role: post.userId.role,
                        isPrivate: post.userId.isPrivate,
                        createdAt: post.userId.createdAt,
                        background: post.userId.backGroundImage,
                        email: post.userId.email,
                        edited: post.editedAt,
                        saved: true,
                        post: post.userId,
                        image: post.image,
                        likes: post.likes,
                        description: post.description,
                        id: post.id,
                        userId: post.userId.id,
                        posts: savedPosts,
                        taggedUsers: post.taggedUsers,
                        blocked: post.blocked,
                        hidden: post.hidden,
                        creartedAt: post.createdAt,
                        updatedAt: post.updatedAt,
                        date: post.date,
                        tags: const [],
                        profilePic: post.userId.profilePic,
                        userName: post.userId.userName,
                        bio:post.description,
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state1 is ExplorerpostLoadingState) {
            return homepageloading(context);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}




