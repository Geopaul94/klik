import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeEditDelete extends StatelessWidget {
  const HomeEditDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
            onPressed: () {
              showPopupMenu(context);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Main Content Here'),
      ),
    );
  }

  void showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 0, 0), // Position of the menu
      items: [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    ).then((value) {
      // Handle menu item selection
      if (value == 'edit') {
        // Perform edit action
      } else if (value == 'delete') {
        // Perform delete action
      }
    });
  }
}
