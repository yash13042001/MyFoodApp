import 'package:flutter/material.dart';
import 'package:my_food_users_app/widgets/progress_bar.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          const SizedBox(height: 10),
          Text("${message!},Please wait..."),
        ],
      ),
    );
  }
}
