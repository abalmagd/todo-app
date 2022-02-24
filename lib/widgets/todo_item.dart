import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final Map tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 8,
          ),
          Expanded(
            child: Column(
              children: [
                Text(tasks['Title']),
                const SizedBox(height: 4),
                Text(tasks['Date']),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: 18,
            icon: const Icon(
              Icons.done,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: 18,
            icon: const Icon(
              Icons.archive,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: 18,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
