import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/errorstate_widget.dart';
import 'package:klik/presentaion/bloc/explorerposts_bloc/explorerpost_bloc.dart';
import 'package:klik/presentaion/bloc/search_user_bloc/explore_page_search_users_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/bb/screen_explore.dart';
import 'package:klik/presentaion/pages/profile_page/CustomeListTile.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/exploring_user_profile.dart';

Widget postsGridViewWidget(ExplorerpostSuccesstate state, Size media,
    BuildContext context, Future<void> Function() onrefresh) {
  if (state.posts.isEmpty) {
    return errorStateWidget("No posts available ",
        const TextStyle(fontWeight: FontWeight.w600), red);
  }

  return RefreshIndicator(
    onRefresh: onrefresh,
    child: MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        final post = state.posts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenExplore(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                post.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                   return const Center(

          child: SizedBox(

            width: 80, // Define a width

            height: 80, // Define a height

            child:   SpinKitPulsingGrid(

                  color: Colors.green, // Set your desired color

                  size: 50.0, // Set the size of the grid

                ),
          ),

        );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: grey,
                  );
                },
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget fetchExploreErrorReloadWidget(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Something went wrong. Try refreshing.',
          style: TextStyle(color: red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () =>
              context.read<ExplorerpostBloc>().add(FetchExplorerPostsEvent()),
          child: const Text('Retry'),
        ),
      ],
    ),
  );
}

// Function to build the list view of users
Widget filteredUsersListView(
  ExplorePageSearchUserSuccesState state,
  Size media,
) {
  return ListView.builder(
    itemBuilder: (context, index) => CustomListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenExploreUserProfile(
                  userId: state.users[index].id.toString(),
                  user: state.users[index]),
            ));
      },
      profileImageUrl: state.users[index].profilePic.toString(),
      buttonText: '',
      titleText: state.users[index].userName.toString(),
      imageSize: media.height * 0.05,
      backgroundColor: kwhiteColor,
      borderRadius: kradius100,
    ),
    itemCount: state.users.length,
  );
}
