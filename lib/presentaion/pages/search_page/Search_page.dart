import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomeAppbarRow(
        height: height,
        width: width,
        title: "Explore",
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
