

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';

import 'package:klik/application/core/widgets/custome_icons.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/domain/model/suggession_users_model.dart';

import 'package:klik/presentaion/bloc/suggessions_bloc/suggessions_bloc.dart';
import 'package:klik/presentaion/bloc/unfollow_user_bloc/unfollow_user_bloc.dart';

// class SuggessionPage extends StatefulWidget {
//   const SuggessionPage({super.key});

//   @override
//   State<SuggessionPage> createState() => _SuggessionPageState();
// }

// class _SuggessionPageState extends State<SuggessionPage> {
//   @override
//   void initState() {
//     context.read<SuggessionsBloc>().add(onSuggessionsIconclickedEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return Scaffold(
//       backgroundColor: black,
//       appBar: appBar(context, height, width),
//       body: BlocConsumer<SuggessionsBloc, SuggessionsState>(
//         listener: (context, state) {

//         },
//         builder: (context, state) {
//           return SafeArea(
//             child: ListView(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 1,
//                   color: const Color.fromARGB(255, 112, 109, 109),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       const CircleAvatar(
//                         radius: 30,
//                         backgroundImage:
//                             AssetImage('assets/user/profilepic.jpg'),
//                       ),
//                       const SizedBox(width: 16),
//                       const Expanded(
//                         child: const Text(
//                           'User Name',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),

//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

class SuggessionPage extends StatefulWidget {
  const SuggessionPage({Key? key}) : super(key: key);

  @override
  State<SuggessionPage> createState() => _SuggessionPageState();
}

class _SuggessionPageState extends State<SuggessionPage> {
  @override
  void initState() {
    super.initState();
    context.read<SuggessionsBloc>().add(onSuggessionsIconclickedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(context, height, width),
      body: BlocBuilder<SuggessionsBloc, SuggessionsState>(
      builder: (context, state) {
        if (state is UserSuggessionsloadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserSuggessionsSuccessState) {
          return SafeArea(
            child: ListView.builder(
              itemCount: state.Suggessions.length,
              itemBuilder: (context, index) {
                final user = state.Suggessions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePic),
                  ),
                  title: Text(
                    user.userName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    user.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: 
                  
                  
                 CustomElevatedButton(
                        text: "Follow",
                        height: 35,
                        width: 70,
                        color: green,
                        fontSize: 12,
                        onPressed: () {},
                      )
                );
              },
            ),
          );
        } else if (state is UserSuggessionsErrorState) {
          return Center(child: Text(state.error, style: const TextStyle(color: Colors.white)));
        } else {
          return const Center(child: Text('No suggestions available', style: TextStyle(color: Colors.white)));
        }
      },
    ),
  );
}


AppBar appBar(BuildContext context, double height, double width) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: black,surfaceTintColor: black,
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            height: height * 0.05,
            width: width * 0.34,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomGradientIcon(icon: CupertinoIcons.back),
            ),
          ),
        ),
        Center(
          child: CustomeLinearcolor(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            text: 'Suggessions',
            gradientColors: [blue, green],
          ),
        ),
      ],
    ),
  );
}
}