import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/domain/model/explore_posts_model.dart';

import 'package:klik/presentaion/bloc/explorerposts_bloc/explorerpost_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/evo/postview.dart';
import 'package:klik/presentaion/pages/explorer_page/evo/user_post_details.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class ExplorePost extends StatefulWidget {
  const ExplorePost({
    super.key,
  });

  @override
  State<ExplorePost> createState() => _ExplorePostState();
}

class _ExplorePostState extends State<ExplorePost> {
  @override
  void initState() {
    super.initState();
    context.read<ExplorerpostBloc>().add(FetchExplorerPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomeAppbarRow(
        height: height,
        width: width,
        title: "Explore",
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        searchIcon: true,
        gradientColors: const [Colors.blue, Colors.green],
      ),
      body: SafeArea(
        child: BlocConsumer<ExplorerpostBloc, ExplorerpostState>(
          listener: (context, state) {
            if (state is ExplorerpostErrorState) {
              customSnackbar(context, 'Error loading posts', red);
            }
          },
          builder: (context, state) {
            if (state is ExplorerpostLoadingState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LoadingAnimationWidget.hexagonDots(
                    color: green,
                    size: 30,
                  ),
                ),
              );
            } else if (state is ExplorerpostSuccesstate) {
              return SizedBox(
                height: height - (height * 0.20),
                child: MasonryGridView.builder(
                  itemCount: state.posts.length,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    final ExplorePostModel post = state.posts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UsersPostDetailsList(initialindex: index);
                            },
                          ),
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.all(3),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: post.image,
                              //  placeholder: (context, url) {
                              // return LoadingAnimationWidget.hexagonDots(
                              //     color: green, size: 30);
                              //    }
                            ),
                          )),
                    );
                  },
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
