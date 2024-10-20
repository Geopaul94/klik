
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/presentaion/bloc/Connectivity/connectivity_bloc.dart';
import 'package:klik/presentaion/pages/bottomnavBAr/bottomNavBar.dart';

// class ConnectivityListener extends StatelessWidget {
//   final Widget child;

//   const ConnectivityListener({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ConnectivityBloc, ConnectivityState>(
//       listener: (context, state) {
//         if (state is ConnectivityOffline) {
//           _showOverlay(context);
//         } else if (state is ConnectivityOnline) {
//           _removeOverlay(context);
//           _showSnackbar(context);
//         Navigator.of(context).push(
//   CupertinoPageRoute<void>(
//     builder: (BuildContext context) {
//       return BottomNavBar();
//     },
//   ),
// );

//         }
//       },
//       child: child,
//     );
//   }

//   void _showOverlay(BuildContext context) {
//     OverlayState overlayState = Overlay.of(context)!;
//     OverlayEntry overlayEntry = OverlayEntry(
//       builder: (context) => const Stack(
//         children: [
//           Center(
//             child: Material(
//               color: Colors.transparent,
//               child: Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image(
//                       image: AssetImage('assets/internetcheckcrop(1).jpg'),
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                     SizedBox(height: 10),
//                     CircularProgressIndicator(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//     overlayState.insert(overlayEntry);
//     context.read<ConnectivityBloc>().overlayEntry = overlayEntry;
//   }

//   void _removeOverlay(BuildContext context) {
//     if (context.read<ConnectivityBloc>().overlayEntry != null) {
//       context.read<ConnectivityBloc>().overlayEntry?.remove();
//       context.read<ConnectivityBloc>().overlayEntry = null;
//     }
//   }

//   void _showSnackbar(BuildContext context) {
//     final snackBar = const SnackBar(
//       content: Text('You are back to online'),
//       duration: Duration(seconds: 2),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }

import 'package:klik/presentaion/pages/nerworkdata/animated_dots.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityOffline) {
          _showOverlay(context);
        } else if (state is ConnectivityOnline) {
          _removeOverlay(context);
          _showSnackbar(context);
          Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (BuildContext context) {
                return const BottomNavBar();
              },
            ),
          );
        }
      },
      child: child,
    );
  }

  void _showOverlay(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            // Makes the image fullscreen
            child: Image.asset(
              'assets/internetcheckcrop(1).jpg', // Your image asset
              fit: BoxFit.cover, // Ensures the image fills the screen
            ),
          ),
          Column(
           
            children: [
              //   CircularProgressIndicator(),
              SizedBox(
                height: height * .90,
              ),

              const Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedText(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
    overlayState.insert(overlayEntry);
    context.read<ConnectivityBloc>().overlayEntry = overlayEntry;
  }

  void _removeOverlay(BuildContext context) {
    if (context.read<ConnectivityBloc>().overlayEntry != null) {
      context.read<ConnectivityBloc>().overlayEntry?.remove();
      context.read<ConnectivityBloc>().overlayEntry = null;
    }
  }
void _showSnackbar(BuildContext context) {
  const snackBar = SnackBar(
    backgroundColor: Colors.green,  
    content: Text(
      'You are back to online',
      textAlign: TextAlign.center, 
      style: TextStyle(
        color: Colors.white,  
        fontSize: 14,         
      ),
    ),
    duration: Duration(seconds: 1),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

}
