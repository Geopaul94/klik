import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/presentaion/bloc/Connectivity/connectivity_bloc.dart';


class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityOffline) {
          _showOverlay(context);
        } else if (state is ConnectivityOnline) {
          _removeOverlay(context);
        }
      },
      child: child,
    );
  }

  void _showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context)!;
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => const Center(
       
        child: Material(
          color: Colors.red,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.signal_wifi_off, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'No internet connection. Please turn on mobile data or WiFi.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
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
}
