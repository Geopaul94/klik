import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/custome_icons.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';




// class CustomeAppbarRow extends StatefulWidget implements PreferredSizeWidget {
//   final double height;
//   final double width;
//   final String title;
//   final Function() onBackButtonPressed;
//   final List<Color> gradientColors;
//   final Color backgroundColor;
//   final Color? iconColor;
//   final bool searchIcon;

//   const CustomeAppbarRow({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.title,
//     required this.onBackButtonPressed,
//     this.gradientColors = const [Colors.blue, Colors.green],
//     this.backgroundColor = Colors.black,
//     this.iconColor,
//     this.searchIcon = false,
//   });

//   @override
//   _CustomeAppbarRowState createState() => _CustomeAppbarRowState();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _CustomeAppbarRowState extends State<CustomeAppbarRow> {
//   // Variable to track if the search field is visible
//   bool _isSearchActive = false;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       surfaceTintColor: widget.backgroundColor,
//       automaticallyImplyLeading: false,
//       backgroundColor: widget.backgroundColor,
//       title: Row(
//         children: [
//           // Back Button
//           GestureDetector(
//             onTap: widget.onBackButtonPressed,
//             child: SizedBox(
//               height: widget.height * 0.05,
//               width: widget.width * 0.2,
//               child: const Align(
//                 alignment: Alignment.centerLeft,
//                 child: CustomGradientIcon(
//                   icon: CupertinoIcons.back,
//                 ),
//               ),
//             ),
//           ),

//           // If search is not active, show the title
//           if (!_isSearchActive)
//             Expanded(
//               child: Center(
//                 child: CustomeLinearcolor(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   text: widget.title,
//                   gradientColors: widget.gradientColors,
//                 ),
//               ),
//             ),

//           // If search is active, show the search field in the same horizontal row
//           if (_isSearchActive)
//             Container(
//                height: widget.height * 0.05,
//             width: widget.width * 0.55,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextFormField(
//                 autofocus: true, // Automatically focus when activated
//                 decoration: const InputDecoration(
//                   hintText: "Search...",
//                   border: InputBorder.none,
//                 ),
//                 onFieldSubmitted: (value) {
//                   // Add search functionality here
//                   print("Searching for $value");
//                 },
//               ),
//             ),

//           // Search Icon
//           if (widget.searchIcon)
//             IconButton(
//               icon: ShaderMask(
//                 shaderCallback: (Rect bounds) {
//                   return LinearGradient(
//                     colors: widget.gradientColors,
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ).createShader(bounds);
//                 },
//                 child: const Icon(
//                   CupertinoIcons.search,
//                   color: Colors.white, // Base color, masked by gradient
//                 ),
//               ),
//               onPressed: () {
//                 // Toggle search field visibility
//                 setState(() {
//                   _isSearchActive = !_isSearchActive;
//                 });
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }



class CustomeAppbarRow extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final String title;
  final Function() onBackButtonPressed;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final Color? iconColor;

  const CustomeAppbarRow({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.onBackButtonPressed,
    this.gradientColors = const [Colors.blue, Colors.green],
    this.backgroundColor = Colors.black,
    this.iconColor,
  });

  @override
  _CustomeAppbarRowState createState() => _CustomeAppbarRowState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomeAppbarRowState extends State<CustomeAppbarRow> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: widget.backgroundColor,
      automaticallyImplyLeading: false,
      backgroundColor: widget.backgroundColor,
      title: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: widget.onBackButtonPressed,
            child: SizedBox(
              height: widget.height * 0.05,
              width: widget.width * 0.2,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: CustomGradientIcon(
                  icon: CupertinoIcons.back,
                ),
              ),
            ),
          ),

          // Title
          Expanded(
            child: Center(
              child: CustomeLinearcolor(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                text: widget.title,
                gradientColors: widget.gradientColors,
              ),
            ),
          ),
        ],
      ),
    );
  }
}