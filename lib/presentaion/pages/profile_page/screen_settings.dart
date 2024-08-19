// import 'package:buzz_buddy/utils/constants.dart';
// import 'package:buzz_buddy/utils/functions.dart';

// import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/showdialogue.dart';
// import 'package:buzz_buddy/view/pages/login/screen_login.dart';
// import 'package:buzz_buddy/view/pages/main_page/screen_main.dart';
// import 'package:buzz_buddy/view/pages/profile/about_us/screen_about_us.dart';
// import 'package:buzz_buddy/view/pages/profile/settings_page/privacy_policy/screen_privacy_policies.dart';
// import 'package:buzz_buddy/view/pages/profile/terms_and_conditions/screen_terms_and_conditions.dart';
// import 'package:buzz_buddy/view/pages/profile/widgets/custom_settings_list_tile.dart';
// import 'package:flutter/material.dart';

// class ScreenSettings extends StatelessWidget {
//   const ScreenSettings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Settings',
//           style: appBarTitleStyle,
//         ),
//         automaticallyImplyLeading: true,
//         // backgroundColor: kPrimaryColor,
//       ),
//       body: Column(
//         children: [
//           customSettingsListTile(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ScreenTermsAndConditions(),
//                 ),
//               );
//             },
//             leading: const Icon(Icons.receipt_long),
//             title: "Terms and conditions ",
//             trailing: const Icon(
//               Icons.arrow_forward_ios,
//               size: 20,
//             ),
//           ),
//           customSettingsListTile(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const PrivacyPolicyPage(),
//                 ),
//               );
//             },
//             leading: const Icon(Icons.privacy_tip_outlined),
//             title: "Privacy Policies",
//             trailing: const Icon(
//               Icons.arrow_forward_ios,
//               size: 20,
//             ),
//           ),
//           customSettingsListTile(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ScreenAboutUs(),
//                 ),
//               );
//             },
//             leading: const Icon(Icons.info_outline),
//             title: "About us",
//             trailing: const Icon(
//               Icons.arrow_forward_ios,
//               size: 20,
//             ),
//           ),
//           customSettingsListTile(
//             onTap: () async {
//               showConfirmationDialog(
//                 context: context,
//                 title: 'Log out!',
//                 content: 'Are you sure..?',
//                 confirmButtonText: "confirm",
//                 cancelButtonText: "cancel",
//                 onConfirm: () async {
//                   await clearUserSession();
//                   await googleSignOut();
//                   currentPage.value = 0;
//                   if (context.mounted) {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) {
//                         return ScreenLogin();
//                       }),
//                       (Route<dynamic> route) => false,
//                     );
//                   }
//                 },
//               );
//             },
//             leading: const Icon(Icons.logout),
//             title: "Logout",
//             trailing: const Icon(
//               Icons.arrow_forward_ios,
//               size: 20,
//             ),
//           ),
//           // Spacer to push the version info to the bottom
//           const Spacer(),
//           // Version and app name
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Buzz Buddy\nVersion 1.0.4',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 15,
//                 color: kPrimaryColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}