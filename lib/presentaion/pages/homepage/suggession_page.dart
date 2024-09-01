
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomeAppbar.dart';
import 'package:klik/presentaion/bloc/suggessions_bloc/suggessions_bloc.dart';

class SuggessionPage extends StatefulWidget {



  const SuggessionPage({super.key});

  @override
  State<SuggessionPage> createState() => _SuggessionPageState();




}

class _SuggessionPageState extends State<SuggessionPage> {


  @override
  void initState() {
context.read<SuggessionsBloc>().add(onSuggessionsIconclickedEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: const CustomAppBar(
        title: "Suggessions",
        backgroundColor: black,
        cupertinoLeadingIcon: CupertinoIcons.back,  showBackArrow: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        AssetImage('assets/user/profilepic.jpg'),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: const Text(
                      'User Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomElevatedButton(
                    text: "Follow",
                    height: 35,
                    width: 70,
                    color: green,
                    fontSize: 12,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
