import 'package:flutter/material.dart';

class CustomLoadingButton extends StatefulWidget {
  final bool isLoading;
  final String title;
  final VoidCallback onPressed;

  CustomLoadingButton({
    required this.isLoading,
    required this.title,
    required this.onPressed,
  });

  @override
  _CustomLoadingButtonState createState() => _CustomLoadingButtonState();
}

class _CustomLoadingButtonState extends State<CustomLoadingButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isLoading ? Colors.grey : Colors.blue, // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      child: widget.isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white, // Loading spinner color
              ),
            )
          : Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
