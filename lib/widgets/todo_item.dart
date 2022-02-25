import 'package:flutter/material.dart';
import 'package:todo_app/blocs/app_bloc/app_cubit.dart';
import 'package:todo_app/core/constants.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final Map tasks;

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: tasks['Priority'] == 1 ? Colors.red : Colors.green,
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
          if (tasks['Type'] == 'Active' || tasks['Type'] == 'Archived')
            IconButton(
              onPressed: () => cubit.dbUpdate(
                id: tasks['Id'],
                typeTo: done,
                typeFrom: tasks['Type'],
              ),
              splashRadius: 18,
              icon: const Icon(
                Icons.done,
                color: Colors.green,
              ),
            ),
          if (tasks['Type'] == 'Active' || tasks['Type'] == 'Done')
            IconButton(
              onPressed: () => cubit.dbUpdate(
                id: tasks['Id'],
                typeTo: archived,
                typeFrom: tasks['Type'],
              ),
              splashRadius: 18,
              icon: const Icon(
                Icons.archive,
                color: Colors.blue,
              ),
            ),
          IconButton(
            onPressed: () => cubit.dbDelete(
              id: tasks['Id'],
              type: tasks['Type'],
            ),
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
