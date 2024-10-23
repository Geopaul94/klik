import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/get_userchatModel.dart';
import 'package:klik/presentaion/bloc/fetchallconversation_bloc/fetch_all_conversations_bloc.dart';
import 'package:klik/presentaion/pages/message_page.dart/chat/chatscreen.dart';

import 'package:klik/presentaion/pages/message_page.dart/widgets/messageloading_shimmer.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController searchController = TextEditingController();
  List<GetUserModel> filteredUsers = [];
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    context
        .read<FetchAllConversationsBloc>()
        .add(AllConversationsInitialFetchEvent());
  }

  Future<void> refresh() async {
    final fetchBloc = context.read<FetchAllConversationsBloc>();
    final completer = Completer<void>();

    fetchBloc.add(AllConversationsInitialFetchEvent());
    fetchBloc.stream.listen((state) {
      if (state is FetchAllConversationsSuccesfulState) {
        completer.complete();
      }
    });

    await completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    

appBar: AppBar(
  backgroundColor: black,
 
  title: Row(
    children: [
   
      const Spacer(), 
      ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.green, Colors.blue],
        ).createShader(bounds),
        child: const Text(
          "Message",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      const Spacer(), 
    ],
  ),
),

  
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: SecondarySearchField(
          //     controller: searchController,
          //     onTextChanged: (String value) {
          //       setState(() {
          //         searchQuery = value;
          //       });
          //     },
          //     onTap: () {},
          //   ),
          // ),
          Expanded(
            child: CustomMaterialIndicator(
              onRefresh: refresh,
              child: BlocBuilder<FetchAllConversationsBloc,
                  FetchAllConversationsState>(
                builder: (context, state) {
                  if (state is FetchAllConversationsLoadingState) {
                    return Center(child: ShimmerLoading());
                  } else if (state is FetchAllConversationsSuccesfulState) {
                    final conversations = state.conversations;
                    final users = state.otherUsers;

                    filteredUsers = users.where((user) {
                      return user.userName.contains(searchQuery ?? '');
                    }).toList();

                    if (filteredUsers.isEmpty) {
                      return const Center(child: Text('No chat found!'));
                    }

                    return ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final conversation = conversations[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  username: user.userName,
                                  recieverid: user.id,
                                  name: user.userName,
                                  profilepic: user.profilePic,
                                  conversationId: conversation.id,
                                ),
                              ),
                            );
                          },
                          child: _buildChatListItem(
                            profileImageUrl: user.profilePic,
                            username: user.userName,
                            messagePreview: conversation.lastMessage ?? '',
                            messageTime: '12:00 PM', // Placeholder
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatListItem({
    required String profileImageUrl,
    required String username,
    required String messagePreview,
    required String messageTime,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color:
              const Color.fromARGB(255, 56, 76, 57), // Set the border color to green

          width: 1, // Set the border thickness to 1
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70, // Set the width of the container
            height: 70, // Set the height of the container
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 216, 209, 209), // Background color for the container
              borderRadius: BorderRadius.circular(10), // Small curved edges
              border: Border.all(
                color: const Color.fromARGB(255, 105, 182, 108), // Green border color
                width: 1, // Border thickness
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  10), // Match the container's border radius
              child: Image.network(
                profileImageUrl,
                fit: BoxFit.cover, // Ensure the image covers the entire area
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 180, 193, 203),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  messagePreview,
                  style: const TextStyle(color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                messageTime,
                style: const TextStyle(
                    color: Color.fromARGB(255, 216, 199, 199), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
