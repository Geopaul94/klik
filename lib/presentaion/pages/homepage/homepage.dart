import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/application/core/widgets/userPost_row_name_and_date.dart';
import 'package:klik/domain/model/all_posts_model.dart';
import 'package:klik/domain/model/comment_model.dart';
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
    context
        .read<GetfollowersPostBloc>()
        .add(FetchFollowersPostEvent(page: _page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
     // backgroundColor: Colors.black,
      body: BlocBuilder<GetfollowersPostBloc, GetfollowersPostState>(
        builder: (context, state) {
      
          if (state is GetfollowersPostLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetfollowersPostSuccessState) {
            return ListView.builder(
              itemCount: state.HomePagePosts.length,
              itemBuilder: (context, index) {
                final post = state.HomePagePosts[index];
                return HomPage_card(HomePagePosts: post);
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

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: black,


      automaticallyImplyLeading: false,
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
    );
  }
}



class HomPage_card extends StatelessWidget {
  final AllPostsModel HomePagePosts;

  const HomPage_card({required this.HomePagePosts});

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return DateFormat('dd MMMM yyyy').format(date.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Card(
      color: Colors.black,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nameAndDateRow(),
            const SizedBox(height: 20),
            if (HomePagePosts.image != null && HomePagePosts.image!.isNotEmpty)
              Container(
                width: double.infinity,
                height: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(HomePagePosts.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                HomePagePosts.description ?? 'No description available',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            row_Bottom_icons(height),
          ],
        ),
      ),
    );
  }

  Row row_Bottom_icons(double height) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.heart,
                      color: Colors.red,
                      size: height * 0.03,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.bubble_left,
                      color: Colors.white,
                      size: height * 0.03,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  CupertinoIcons.bookmark,
                  color: Colors.white,
                  size: height * 0.03,
                ),
                onPressed: () {
                  // Save button pressed
                },
              ),
            ],
          );
  }

  Row nameAndDateRow() {
    return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  HomePagePosts.userId?.profilePic ?? '',
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HomePagePosts.userId?.userName ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _formatDate(HomePagePosts.date),
                    style: TextStyle(
                      color: grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
