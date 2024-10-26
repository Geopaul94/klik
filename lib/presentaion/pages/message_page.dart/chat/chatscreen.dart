import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/all_message_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/add_message/add_message_bloc.dart';
import 'package:klik/presentaion/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:klik/presentaion/bloc/fetchallconversation_bloc/fetch_all_conversations_bloc.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/message_page.dart/chat/date_divider.dart';
import 'package:klik/presentaion/pages/message_page.dart/widgets/messageloading_shimmer.dart';

import 'package:klik/presentaion/pages/profile_page/my_post_delete_edit/my_post_page.dart';
import 'package:klik/services/socket/socket.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String recieverid;
  final String name;
  final String username;
  final String profilepic;

  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.recieverid,
    required this.name,
    required this.profilepic,
    required this.username,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ConversationBloc>().add(
          GetAllMessagesInitialFetchEvent(
            conversationId: widget.conversationId,
          ),
        );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: black,
        elevation: 1.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.green, Colors.blue], // Gradient colors
            ).createShader(bounds),
            child: const Icon(
              CupertinoIcons.back,
              size: 24, // Adjust size as needed
              color: Colors.white, // Set to white to see the gradient
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Align children horizontally
          children: [
            const SizedBox(
                width: 10), // Add some space between the icon and the username
            Expanded(
              child: Align(
                alignment: Alignment.center, // Center the username horizontally
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.green, Colors.blue], // Gradient colors
                  ).createShader(bounds),
                  child: Text(
                    widget.username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.white, // Set to white to see the gradient
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 50, // Adjust size to be larger than the CircleAvatar
              height: 50, // Adjust size to be larger than the CircleAvatar
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.green, // Border color
                  width: 1, // Border width
                ),
              ),
              child: CircleAvatar(
                radius:
                    25, // This should be half of the Container's width/height
                backgroundImage: NetworkImage(widget.profilepic),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(
            255, 27, 26, 26), // Set background color to white
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<ConversationBloc, ConversationState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is GetAllMessagesLoadingState) {
                      return const Center(
                        child: ShimmerLoading(),
                      );
                    }
                    if (state is GetAllMessagesSuccesfulState) {
                      List<DateTime> dates = [];
                      List<List<AllMessagesModel>> messagesByDate = [];
                      for (var message in state.messagesList) {
                        DateTime date = DateTime(
                          message.createdAt.year,
                          message.createdAt.month,
                          message.createdAt.day,
                        );
                        if (!dates.contains(date)) {
                          dates.add(date);
                          messagesByDate.add([message]);
                        } else {
                          messagesByDate.last.add(message);
                        }
                      }
                      dates = dates.reversed.toList();
                      messagesByDate = messagesByDate.reversed.toList();
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: dates.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              DateDivider(date: dates[index]),
                              ...messagesByDate[index]
                                  .map((message) => getMessageCard(message)),
                            ],
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              _buildMessageInput(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: TextFormField(
              controller: _messageController,
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 65, 60, 60),
                hintText: 'Type a message...',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: GestureDetector(
            onTap: () {
              if (_messageController.text.isNotEmpty) {
                SocketService().sendMessgage(
                    _messageController.text,
                    widget.recieverid,

//changed loggineduserid to currentuserid         logginedUserId,

                    currentuserId);
                final message = AllMessagesModel(
                  id: '',

//changed loggineduserid to currentuserid         logginedUserId,
                  senderId: currentuserId,

                  recieverId: widget.recieverid,
                  conversationId: widget.conversationId,
                  text: _messageController.text,
                  isRead: false,
                  deleteType: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  v: 0,
                );
                BlocProvider.of<ConversationBloc>(context)
                    .add(AddNewMessageEvent(message: message));
                context.read<AddMessageBloc>().add(AddMessageButtonClickEvent(
                    message: _messageController.text,

//changed loggineduserid to currentuserid         logginedUserId,
                    senderId: currentuserId,
                    recieverId: widget.recieverid,
                    conversationId: widget.conversationId));
                context
                    .read<FetchAllConversationsBloc>()
                    .add(AllConversationsInitialFetchEvent());
                _messageController.clear();

                context.read<ConversationBloc>().add(
          GetAllMessagesInitialFetchEvent(
            conversationId: widget.conversationId,
          ),
        );

              } context.read<ConversationBloc>().add(
          GetAllMessagesInitialFetchEvent(
            conversationId: widget.conversationId,
          ),
        );


              
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: green,
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getMessageCard(AllMessagesModel message) {
    // changed here  bool isSender = message.senderId ==logginedUserId;

    bool isSender = message.senderId == currentuserId;

    //  ;

    // Check if the current user is the sender

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isSender ? green : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isSender ? 12 : 0),
            topRight: Radius.circular(isSender ? 0 : 12),
            bottomLeft: const Radius.circular(12),
            bottomRight: const Radius.circular(12),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
