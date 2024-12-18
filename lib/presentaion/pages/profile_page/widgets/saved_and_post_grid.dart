import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/my_post_model.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/my_post_delete_edit/my_post_page.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/loading_animation_and_error_idget.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/saved_post_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// class MyPostsGrid extends StatelessWidget {
//   final List<MyPostModel> post;

//    MyPostsGrid({super.key, required this.post});

//   @override
//   Widget build(BuildContext context) {
//     if (post.isEmpty) {
//       return const Center(
//         child: Text(
//           'No posts available',
//           style: greyMeduim,
//         ),
//       );
//     }
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: post.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {

//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MyPostsScreen(index: index, post: post),
//               ),
//             );
//           },
//           child: CachedNetworkImage(
//             imageUrl: post[index].image.toString(),
//             fit: BoxFit.cover,
//             placeholder: (context, url) {
//               return LoadingAnimationWidget.fourRotatingDots(
//                   color: grey, size: 30);
//             },
//           ),
//         );
//       },
//     );
//   }
// }

class MyPostsGrid extends StatelessWidget {
  final List<MyPostModel> post;

  const MyPostsGrid({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    if (post.isEmpty) {
      return const Center(
        child: Text(
          'No posts available',
          style: greyMeduim,
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: post.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyPostsScreen(
                  index: index,
                  post: post,
                ),
              ),
            );
          },
          child: CachedNetworkImage(
            imageUrl: post[index].image.toString(),
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return LoadingAnimationWidget.fourRotatingDots(
                  color: grey, size: 30);
            },
          ),
        );
      },
    );
  }
}





class SavedPostsGrid extends StatelessWidget {
  const SavedPostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSavedPostsBloc, FetchSavedPostsState>(
      builder: (context, state) {
        if (state is FetchSavedPostsSuccesfulState) {
          if (state.posts.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  SavedPostScreen(index: index, posts:state.posts,),
                        ));
                  },
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return LoadingAnimationWidget.fourRotatingDots(
                          color: grey, size: 30);
                    },
                    imageUrl: state.posts[index].postId.image,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          } else {
            return errorStateWidget('no items found', greyMeduim);
          }
        } else if (state is FetchSavedPostsLoadingState) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: kPrimaryColor, size: 30),
          );
        } else {
          return errorStateWidget('something went wrong', greyMeduim);
        }
      },
    );
  }
}
