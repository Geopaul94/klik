import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/domain/model/all_posts_model.dart';
import 'package:klik/presentaion/bloc/get_followers_post_bloc/getfollowers_post_bloc.dart';
import 'package:klik/presentaion/pages/homepage/suggession_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 1;

  @override
  void initState() {
    super.initState();
    // Trigger the BLoC event to fetch posts
    context
        .read<GetfollowersPostBloc>()
        .add(FetchFollowersPostEvent(page: _page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/croped_headline.png',
              height: 30,
            ),
            CustomeLinearcolor(
                text: "Share Moments", gradientColors: [green, blue]),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => SuggessionPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: const Icon(
                CupertinoIcons.person_add_solid,
                color: grey,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<GetfollowersPostBloc, GetfollowersPostState>(
        builder: (context, state) {
          // Handle UI based on state
          if (state is GetfollowersPostLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetfollowersPostSuccessState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.userId.toString()),
                  subtitle: Text(post.description ?? ''),
                  leading: Image.network(post.image),
                );
              },
            );
          } else if (state is GetfollowersPostErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('No posts available'));
          }
        },
      ),
    );
  }
}
