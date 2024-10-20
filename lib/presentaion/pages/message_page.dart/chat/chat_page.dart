
 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/get_userchatModel.dart';
import 'package:klik/presentaion/bloc/fetchallconversation_bloc/fetch_all_conversations_bloc.dart';
import 'package:klik/presentaion/pages/message_page.dart/bchatpages/chat_screen.dart';




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
      appBar: AppBar(title: const Text('Message', )),
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
              child:
                  BlocBuilder<FetchAllConversationsBloc, FetchAllConversationsState>(
                builder: (context, state) {
                  if (state is FetchAllConversationsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
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
        color: grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(profileImageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  messagePreview,
                  style: TextStyle(color: Colors.grey[400]),
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
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

