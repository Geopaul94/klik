import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:klik/application/core/constants/constants.dart';

import 'package:klik/application/core/widgets/custome_icons.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/domain/model/my_post_model.dart';

import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/bloc/login_user_details/login_user_details_bloc.dart';

import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPostsScreen extends StatefulWidget {
  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 16, 16),
      appBar: CustomeAppbarRow ( height: height,
  width: width,
  title: 'My Posts',
  onBackButtonPressed: () {
    Navigator.pop(context);
  },
  gradientColors: [blue, green],
  backgroundColor: black,
  iconColor: Colors.white,) ,
 


      body: BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
        builder: (context, state) {
          if (state is FetchMyPostLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchMyPostSuccesState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Myposts_card(post: post);
              },
            );
          } else if (state is FetchMyPostErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('No posts found.'));
          }
        },
      ),
    );
  
  }
}

class Myposts_card extends StatelessWidget {
  final MyPostModel post;

  Myposts_card({required this.post});

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
           



            UserRowWidget(
  profileImageUrl: post.userId!.profilePic.toString(),
  userName: post.userId!.userName.toString(),
  date: _formatDate(post.updatedAt),
  onIconTap: (TapDownDetails details) {
    showPopupMenu(context, details.globalPosition);
  },
  imageRadius: width * 0.08,
  userNameColor: Colors.white,
  dateColor: Colors.grey,
  userNameFontSize: 18.0,
  dateFontSize: 14.0,
)
,

            const SizedBox(height: 20),

            // Post image
            if (post.image!.isNotEmpty)
              Container(
                width: double.infinity,
                height: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(post.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 2),

            const SizedBox(height: 10),

            // Post description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.description.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

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
                      onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
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
}


class UserRowWidget extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String date;
  final double imageRadius;
  final Function(TapDownDetails) onIconTap;
  final Color userNameColor;
  final Color dateColor;
  final double userNameFontSize;
  final double dateFontSize;

  const UserRowWidget({
    Key? key,
    required this.profileImageUrl,
    required this.userName,
    required this.date,
    required this.onIconTap,
    this.imageRadius = 30.0,
    this.userNameColor = Colors.white,
    this.dateColor = Colors.grey,
    this.userNameFontSize = 18.0,
    this.dateFontSize = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: imageRadius,
          backgroundImage: NetworkImage(profileImageUrl),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(
                color: userNameColor,
                fontSize: userNameFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                color: dateColor,
                fontSize: dateFontSize,
              ),
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTapDown: onIconTap,
          child: Icon(
            CupertinoIcons.ellipsis_vertical,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}




class CustomeAppbarRow extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final String title;
  final Function() onBackButtonPressed;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final Color? iconColor;

  const CustomeAppbarRow({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.onBackButtonPressed,
    this.gradientColors = const [Colors.blue, Colors.green],
    this.backgroundColor = Colors.black,
    this.iconColor,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: backgroundColor,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: Row(
        children: [
          GestureDetector(
            onTap: onBackButtonPressed,
            child: SizedBox(
              height: height * 0.05,
              width: width * 0.34,
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomGradientIcon(icon: CupertinoIcons.back, ),
              ),
            ),
          ),
          Center(
            child: CustomeLinearcolor(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              text: title,
              gradientColors: gradientColors,
            ),
          ),
        ],
      ),
    );
  }
}
