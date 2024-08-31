import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/presentaion/bloc/allusers_post/all_user_s_post_bloc.dart';
import 'package:klik/presentaion/pages/homepage/suggession_page.dart';

class PostModel {
  final String username;
  final String postDate;
  final String userImage;
  final String postImage;

  PostModel({
    required this.username,
    required this.postDate,
    required this.userImage,
    required this.postImage,
  });
}

class PostList extends StatefulWidget {
  final List<PostModel> posts;

  const PostList({Key? key, required this.posts}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    context
        .read<AllUserSPostBloc>()
        .add(onUsersPostfetchEvent(startIndex: 0, limit: 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        final post = widget.posts[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: width * 0.08,
                  backgroundImage: AssetImage(post.userImage),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Posted on ${post.postDate}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    showPopupMenu(context, details.globalPosition);
                  },
                  child: const Icon(CupertinoIcons.ellipsis_vertical),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: height * 0.4,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(post.postImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Row(
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
                      onPressed: () {
                        // Like button pressed
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.bubble_left,
                        color: Colors.white,
                        size: height * 0.03,
                      ),
                      onPressed: () {
                        // Comment button pressed
                      },
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
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = [
      PostModel(
        username: 'User1',
        postDate: 'August 28, 2024',
        userImage:
            'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
      PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage:
            'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
      PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage:
            'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
      PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage:
            'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
      PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage:
            'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
      PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage:
            'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
      PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage:
            'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
    ];

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
            GestureDetector(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SuggessionPage();

              },));
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
      body: PostList(posts: posts),
    );
  }
}

void showPopupMenu(BuildContext context, Offset tapPosition) {
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      tapPosition.dx,
      tapPosition.dy,
      tapPosition.dx + 10,
      tapPosition.dy + 10,
    ),
    items: [
      const PopupMenuItem(
        value: 'edit',
        child: Row(
          children: [
            Icon(Icons.edit, color: Colors.blue),
            SizedBox(width: 8),
            Text('Edit'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete'),
          ],
        ),
      ),
    ],
  ).then((value) {
    // Handle menu item selection
    if (value == 'edit') {
      // Perform edit action
    } else if (value == 'delete') {
      // Perform delete action
    }
  });
}
