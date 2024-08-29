
   import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



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

class PostList extends StatelessWidget {
  final List<PostModel> posts;

  const PostList({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: width * 0.08,
                  backgroundImage: AssetImage(post.userImage), // User profile image
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username, // User name
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Posted on ${post.postDate}', // Post date
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),  // Pushes the following widget to the far right
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
                  image: AssetImage(post.postImage), // Image for the post
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
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                        size: height * 0.03,
                      ),
                      onPressed: () {
                        // Like button pressed
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.chart_bar,
                        color: Colors.white,
                        size: height * 0.03,
                      ),
                      onPressed: () {
                        // Comment button pressed
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.bookmark_fill,
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
    // Sample data
    final posts = [
      PostModel(
        username: 'User1',
        postDate: 'August 28, 2024',
        userImage: 'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
      PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage: 'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),   PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage: 'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),   PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage: 'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),   PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage: 'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),   PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage: 'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),   PostModel(
        username: 'User2',
        postDate: 'August 28, 2024',
        userImage: 'assets/20_IG_layout_march_2022_Taylor_Kemp_Photography_taylorkempphotography_00590.webp',
        postImage: 'assets/308dad18-bea5-ba0b-4921-878ed959b05d-714x402.webp',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: PostList(posts: posts),
    );
  }
}
