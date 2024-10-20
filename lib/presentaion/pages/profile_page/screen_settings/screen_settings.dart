import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomeAppbar.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';
import 'package:klik/presentaion/pages/profile_page/screen_settings/about_us_page.dart';
import 'package:klik/presentaion/pages/profile_page/screen_settings/privacy_and_policypage.dart';
import 'package:klik/presentaion/pages/profile_page/screen_settings/terms_and_condition_page.dart';



class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Settings",
        leadingIcon: CupertinoIcons.back,
        leadingIconPadding: 0,
      ),
      body: Column(
        children: [
          Divider(color: grey100, thickness: 1),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CustomIconTextIconList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconTextIconList extends StatelessWidget {
  const CustomIconTextIconList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ListItem> items = [
      ListItem(
        startIcon: Icons.info_outline,
        text: 'About Us',
        endIcon: CupertinoIcons.forward,
        textColor: Colors.white,
        startIconColor: Colors.white,
        endIconColor: Colors.white,
        iconSize: 24.0,
        textSize: 24.0,
        onTap: () {
          // Navigate to About Us page

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutUsPage()),
          );
        },
      ),
      ListItem(
        startIcon: Icons.privacy_tip,
        text: 'Privacy Policies',
        endIcon: CupertinoIcons.forward,
        textColor: Colors.white,
        startIconColor: Colors.white,
        endIconColor: Colors.white,
        iconSize: 24.0,
        textSize: 24.0,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PrivacyPoliciesPage()),
          );
        },
      ),
      ListItem(
        startIcon: Icons.forum,
        text: 'Terms & Condition',
        endIcon: CupertinoIcons.forward,
        textColor: Colors.white,
        startIconColor: Colors.white,
        endIconColor: Colors.white,
        iconSize: 24.0,
        textSize: 24.0,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TermsAndConditionsPage()),
          );
        },
      ),
      ListItem(
        startIcon: Icons.logout,
        text: 'Logout',
        endIcon: CupertinoIcons.forward,
        textColor: white,
        startIconColor: Colors.red,
        endIconColor: Colors.white,
        iconSize: 24.0,
        textSize: 24.0,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return alertBox(context);
            },
          );
        },
      ),
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return CustomListItemWidget(item: item);
      },
    );
  }

  AlertDialog alertBox(BuildContext context) {
    return AlertDialog(backgroundColor: const Color.fromARGB(255, 26, 24, 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      title: const Text(
        "Logout Confirmation",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        "Are you sure you want to logout?",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      actions: [
     ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    foregroundColor: Colors.black, // Use Colors.black for foregroundColor
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6), // Adjust the radius as needed
    ),
  ),
  onPressed: () {
    Navigator.pop(context);
  },
  child: const Text("Cancel"),
),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: white,shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6), // Adjust the radius as needed
    ),
          ),
          onPressed: () async {
            await clearUserSession();

            await googleSignOut();

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: const Text("Logout",selectionColor:black,),
        ),
      ],
    );
  }
}

class CustomListItemWidget extends StatelessWidget {
  final ListItem item;

  const CustomListItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              item.startIcon,
              color: item.startIconColor,
              size: item.iconSize,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * .04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.text,
                style: TextStyle(
                  fontSize: item.textSize,
                  color: item.textColor,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              item.endIcon,
              color: item.endIconColor,
              size: item.iconSize,
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem {
  final IconData startIcon;
  final String text;
  final IconData endIcon;
  final Color textColor;
  final Color startIconColor;
  final Color endIconColor;
  final double iconSize;
  final double textSize;
  final VoidCallback? onTap;

  ListItem({
    required this.startIcon,
    required this.text,
    required this.endIcon,
    required this.textColor,
    required this.startIconColor,
    required this.endIconColor,
    required this.iconSize,
    required this.textSize,
    this.onTap,
  });
}
