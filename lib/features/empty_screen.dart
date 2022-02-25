import 'package:flutter/material.dart';
import 'package:todo_app/core/constants.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.find_in_page, size: height * 0.2),
          const SizedBox(height: kSmallSpacing),
          const Text(
            'There are no tasks here!',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
