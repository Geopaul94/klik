
// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:klik/application/core/constants/constants.dart';
// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';


// import 'package:klik/domain/model/conversationModel.dart';
// import 'package:klik/domain/model/get_userchatModel.dart';
// import 'package:klik/presentaion/bloc/add_message/add_message_bloc.dart';
// import 'package:klik/presentaion/bloc/fetchallconversation_bloc/fetch_all_conversations_bloc.dart';
// import 'package:klik/presentaion/pages/message_page.dart/bchatpages/chat_screen.dart';
// import 'package:klik/presentaion/pages/message_page.dart/bchatpages/custome_card.dart';
// import 'package:klik/presentaion/pages/message_page.dart/bchatpages/message_loading_shimmer.dart';
// import 'package:klik/presentaion/pages/message_page.dart/bchatpages/newchat_screen.dart';

// import 'package:loading_animation_widget/loading_animation_widget.dart';


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_bloc_builder/multi_bloc_builder.dart';

// class FindChatPersonScreen extends StatefulWidget {
//   const FindChatPersonScreen({super.key});

//   @override
//   State<FindChatPersonScreen> createState() => _FindChatPersonScreenState();
// }

// class _FindChatPersonScreenState extends State<FindChatPersonScreen> {
//   final searchPersonController = TextEditingController();
//   List<ConversationModel> conversations = [];
//   List<GetUserModel> users = [];
//   List<GetUserModel> filteredUsers = [];
//   String? onchanged;

//   final searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<FetchAllConversationsBloc>()
//         .add(AllConversationsInitialFetchEvent());
//   }

//   Future<void> refresh() async {
//     final fetchBloc = context.read<FetchAllConversationsBloc>();
//     final refreshCompleter = Completer<void>();

//     fetchBloc.add(AllConversationsInitialFetchEvent());
//     fetchBloc.stream.listen((state) {
//       if (state is FetchAllConversationsSuccesfulState) {
//         refreshCompleter.complete();
//       }
//     });

//     await refreshCompleter.future;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text(
//           'chat hub',
//           style: appBarTitleStyle,
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size(size.width, 50),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15.0, right: 15),
//             child: Column(
//               children: [
//                 SearchBar(
//                   leading: const Icon(Icons.search),
//                   onChanged: (value) {
//                     onchanged = value;
//                     setState(() {});
//                   },
//                   controller: searchController,
//                   hintText: 'Search...',
//                 ),
//                 kheight
//               ],
//             ),
//           ),
//         ),
//       ),
//         body: CustomMaterialIndicator(
//       indicatorBuilder: (context, controller) {
//         return LoadingAnimationWidget.inkDrop(
//           color: Colors.black,
//           size: 30,
//         );
//       },
//       onRefresh: refresh, // Your refresh logic
//       child: MultiBlocBuilder(
//         blocs: [
//           context.watch<FetchAllConversationsBloc>(),
//           context.watch<AddMessageBloc>(),
//         ],
//         builder: (context, state) {
//           var state1 = state[0];
          
//           // Check if conversations are loading
//           if (state1 is FetchAllConversationsLoadingState) {
//             return Center(
//               child: messageScreenShimmerLoading(),
//             );
//           } 
//           // Check if conversations were fetched successfully
//           else if (state1 is FetchAllConversationsSuccesfulState) {
//             conversations = state1.conversations;
//             users = state1.otherUsers;
//             filteredUsers = state1.otherUsers.where(
//                 (element) => element.userName.contains(onchanged ?? '')
//             ).toList();

//             // If no users found, show a message
//             return filteredUsers.isEmpty
//                 ? const Center(
//                     child: Text('No chat found!'),
//                   )
//                 : ListView.builder(
//                     itemCount: filteredUsers.length,
//                     itemBuilder: (context, index) {
//                       final ConversationModel conversation = conversations[index];
//                       final user = filteredUsers[index];
//                       return Center(
//                         child: Container(
//                           constraints: const BoxConstraints(maxWidth: 500),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ChatScreen(
//                                     username: user.userName,
//                                     recieverid: user.id,
//                                     name: user.userName,
//                                     profilepic: user.profilePic,
//                                     conversationId: conversation.id,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: CustomCard(
//                               user: user,
//                               conversation: conversation,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//           } 
//           // Default case if no valid state is found
//           else {
//             return const SizedBox();
//           }
//         },
//       ),
//     ),
//     floatingActionButton: Padding(
//       padding: const EdgeInsets.only(bottom: 60.0),
//       child: FloatingActionButton(
//         backgroundColor: Colors.blueAccent,
//         shape: const CircleBorder(),
//         onPressed: () {
//           Navigator.of(context).push(PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) =>
//                 const NewChatScreen(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               const begin = Offset(1.0, 0.0);
//               const end = Offset.zero;
//               const curve = Curves.ease;

//               var tween = Tween(begin: begin, end: end)
//                   .chain(CurveTween(curve: curve));

//               var offsetAnimation = animation.drive(tween);

//               return SlideTransition(
//                 position: offsetAnimation,
//                 child: child,
//               );
//             },
//           ));
//         },
//         child: const Icon(
//           CupertinoIcons.person_add_solid,
//           color: Colors.white,
//         ),
//       ),
//     ),
//       );
//     }
//   }
