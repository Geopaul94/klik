
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/domain/model/all_message_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/main.dart';
import 'package:klik/presentaion/bloc/conversation_bloc/conversation_bloc.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  io.Socket socket = io.io(
    'wss://4tlmk160-7002.asse.devtunnels.ms',
    io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );

  void connectSocket({required BuildContext context}) async {
    final BuildContext? ctx = NavigationService.navigatorKey.currentContext;

    if (socket.disconnected) {
      socket.connect();

      socket.off("getMessage");

      socket.on("getMessage", (data) {
        debugPrint('inside get message - ${data['text']}');
        final message = AllMessagesModel(
          id: '',
          senderId: data['senderId'],
          recieverId: data['recieverId'],
          conversationId: '',
          text: data['text'],
          isRead: false,
          deleteType: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          v: 0,
        );

        if (ctx != null) {
          ctx
              .read<ConversationBloc>()
              .add(AddNewMessageEvent(message: message));
        }
  
        context
            .read<ConversationBloc>()
            .add(AddNewMessageEvent(message: message));
      });
    }

    socket.onConnect((data) {
      debugPrint('Connection established');
    });
    socket.onConnectError((data) => debugPrint('connect error:$data'));
    socket.onDisconnect((data) => debugPrint('Socket.IO server disconnected'));

    final id = await getUserId();

    socket.emit("addUser", id);
  }

  sendMessgage(String message, String receiverId, String senderId) {
    socket.emit('sendMessage', {
      "senderId": senderId,
      "recieverId": receiverId,
      "text": message,
    });
  }

  void disconnectSocket() {
    socket.disconnect();
    socket.clearListeners();
  }
}
