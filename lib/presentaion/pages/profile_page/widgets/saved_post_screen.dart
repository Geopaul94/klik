import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';

import 'package:klik/application/core/widgets/userPost_row_name_and_date.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/saved_post_model.dart';

import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/homepage/like_button.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/customesavelikebutton.dart';
import 'package:like_button/like_button.dart';

// class SavedPostScreen extends StatefulWidget {

//   final int index;
//   final List<SavedPostModel> post;
//   const SavedPostScreen({super.key, required this.index, required this.post});

//   @override
//   State<SavedPostScreen> createState() => _SavedPostScreenState();
// }

// class _SavedPostScreenState extends State<SavedPostScreen> {



//   final ScrollController _scrollController = ScrollController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
        
//   }
//   @override





  
//   Widget build(BuildContext context) { final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return Scaffold(


//       appBar:CustomeAppbarRow(
//         height: height,
//         width: width,
//         title: 'Saved Posts',
//         onBackButtonPressed: () {
//           Navigator.pop(context);
//         },
//         gradientColors: [blue, green],
//         backgroundColor: black,
//         iconColor: Colors.white,
//       ), 
//       body: BlocBuilder<FetchSavedPostsBloc, FetchSavedPostsState>(
//         builder: (context, savedpost) {

// if (savedpost is  FetchSavedPostsSuccesfulState) {
  

//  WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_scrollController.hasClients) {
//                 _scrollController.jumpTo(widget.index * 535);
//               }
//             });





//           return ListView.builder(  controller: _scrollController,  itemCount: savedpost.posts.length,  itemBuilder: (context, index) {
//                  final post = savedpost.posts[index];
//                 return SavedPostsCard(
//                   post: post,
//                   index: index,
//                 );
//               },
          
            
//           },);
     

// }   },
      
      
      
      
      



class SavedPostScreen extends StatefulWidget {
  final int index;
  final List<SavedPostModel> posts;

  const SavedPostScreen({
    Key? key,
    required this.index,
    required this.posts,
  }) : super(key: key);

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(widget.index * 535);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomeAppbarRow(
        height: size.height,
        width: size.width,
        title: 'Saved Posts',
        onBackButtonPressed: () => Navigator.pop(context),
        gradientColors: [blue, green],
        backgroundColor: black,
        iconColor: Colors.white,
      ),
      body: BlocBuilder<FetchSavedPostsBloc, FetchSavedPostsState>(
        builder: (context, state) {
          if (state is FetchSavedPostsSuccesfulState) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return SavedPostsCard(
                  post: post,
                  index: index,
                );
              },
            );
          }
          // Handle other states (loading, error, etc.)
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
      
  

  class SavedPostsCard extends StatefulWidget {




     final SavedPostModel post;

  final int index;

  
  const SavedPostsCard({super.key, required this.post, required this.index});

  @override
  State<SavedPostsCard> createState() => _SavedPostsCardState();
}

class _SavedPostsCardState extends State<SavedPostsCard> {



String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return DateFormat('dd MMMM yyyy').format(date.toLocal());
  }

  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> comments = [];



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
              showIcon: false,
              profileImageUrl: widget.post.postId.userId.profilePic,
            userName: widget.post.postId.userId.userName,
              date: _formatDate(widget.post.updatedAt),
              onIconTap: (TapDownDetails details) {
                
              },
              imageRadius: width * 0.08,
              userNameColor: Colors.white,
              dateColor: Colors.grey,
              userNameFontSize: 18.0,
              dateFontSize: 14.0,
            ),

            const SizedBox(height: 20),

            // Post image
            if (widget.post.postId.image.isNotEmpty)
              Container(
                width: double.infinity,
                height: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage( widget. post.postId. image.toString()),
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
          widget.      post.postId  .description.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

            bottom_raw_card(height),
          ],
        ),
      ),
    );
  }

  Row bottom_raw_card(double height) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
           Customesavelikebutton(
      post: widget.post,
      currentUserId: currentUser.toString(), // You need to implement this function to get the current user's ID
    ),
                
                
                
                
            Row(
  children: [
    IconButton(
      icon: Icon(
        CupertinoIcons.bubble_left,
        color: Colors.white,
        size: height * 0.03,
      ),
      onPressed: () async {
        // Accessing the username from the correct nested structure
        String userName = widget.post.postId.userId.userName;
        
        // Accessing the profile picture
        String profilePic = widget.post.postId.userId.profilePic;
        
        debugPrint(profilePic);
        
        // Now pass these values to the AddComment widget
        await showModalBottomSheet(
          context: context,
          builder: (context) => AddComment(
            profilePic: profilePic,
            userName: userName,
            comments: comments, // Make sure 'comments' is defined
            id: widget.post.postId.id, onCommentAdded: () {  }, onCommentDeleted: () {  }, // Using the correct ID from SavedPostModel
          ),
        );
      },
    ),
  //  Text(widget.post.postId.taggedUsers.length.toString()), // Assuming taggedUsers is used for comment count
  ],
),
                ]),



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

}