


import 'package:flutter/material.dart';
import 'package:klik/domain/model/all_message_model.dart';
import 'package:klik/presentaion/pages/message_page.dart/bchatpages/chat_page/otheruser_message_card.dart';
import 'package:klik/presentaion/pages/message_page.dart/bchatpages/chat_page/our_message_card.dart';
import 'package:klik/presentaion/pages/profile_page/my_post_delete_edit/my_post_page.dart';


Widget getMessageCard(AllMessagesModel message) {
  if (message.senderId == logginedUserId) {
    return OwnMessageCard(
      message: message.text.trim(),
      time: message.createdAt,
    );
  } else {
    return ReplayCard(
      message: message.text.trim(),
      time: message.updatedAt,
    );
  }
}