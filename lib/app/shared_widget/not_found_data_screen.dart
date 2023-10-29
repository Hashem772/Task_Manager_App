import 'package:flutter/material.dart';

class NotFoundDataScreen extends StatelessWidget {
  IconData icon;
   String errorText;
  NotFoundDataScreen({required this.icon, required this.errorText});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,

          ),
          Text(errorText)
        ],
      ),
    );
  }
}
