import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';

import 'package:klik/application/core/widgets/custome_icons.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';

import 'package:klik/presentaion/bloc/suggessions_bloc/suggessions_bloc.dart';
import 'package:klik/presentaion/bloc/unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:klik/presentaion/pages/bottomnavBAr/bottomNavBar.dart';

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
            if (state.suggessionUserModelList.isEmpty) {
              // Display message when the list is empty
              return const Center(
                child: Text(
                  'No suggestions available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              // Build the list when the list is not empty
              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: const Color.fromARGB(255, 95, 94, 94),
                      width: double.infinity,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.suggessionUserModelList.length,
                        itemBuilder: (context, index) {
                          final user = state.suggessionUserModelList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                user.profilePic.toString(),
                              ),
                            ),
                            title: Text(
                              user.userName.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              user.email.toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: CustomElevatedButton(
                              text: "Follow",
                              height: height * .043,
                              width: width * .18,
                              color: green,
                              fontSize: 12,
                              onPressed: () {
                                // Trigger RemoveSuggessionUserEvent to update the list and refresh
                                context.read<SuggessionsBloc>().add(
                                      RemoveSuggessionUserEvent(
                                        userId: user.id.toString(),
                                      ),
                                    );

                                // Trigger FollowUserButtonClickEvent to handle the follow action
                                context.read<UnfollowUserBloc>().add(
                                      FollowUserButtonClickEvent(
                                        followersId: user.id.toString(),
                                      ),
                                    );

                                // Navigate to the BottomNavBar after follow action
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavBar()),
                                  (Route<dynamic> route) =>
                                      false, // This ensures the user cannot return to the suggestion page
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (state is UserSuggessionsErrorState) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No suggestions available',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}

AppBar appBar(BuildContext context, double height, double width) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: black,
    surfaceTintColor: black,
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
            text: 'Suggestions',
            gradientColors: [blue, green],
          ),
        ),
      ],
    ),
  );
}
