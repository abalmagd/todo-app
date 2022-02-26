import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_cubit.dart';
import 'package:todo_app/blocs/app_bloc/app_states.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/features/active_screen.dart';
import 'package:todo_app/features/archived_screen.dart';
import 'package:todo_app/features/done_screen.dart';

import '../widgets/task_form.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  final screens = const [
    ActiveScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
            actions: [
              PopupMenuButton(
                onSelected: (_) => cubit.dbClear(),
                itemBuilder: (BuildContext context) {
                  return {'Clear all'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: screens[cubit.navIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => const TaskForm(),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.navIndex,
            onTap: (index) => cubit.changeNavIndex(index: index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: active,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.done),
                label: done,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive),
                label: archived,
              ),
            ],
          ),
        );
      },
    );
  }
}
