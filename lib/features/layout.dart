import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_cubit.dart';
import 'package:todo_app/blocs/app_bloc/app_states.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/features/archived_screen.dart';
import 'package:todo_app/features/done_screen.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/task_screen.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  final screens = const [
    HomeScreen(),
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
          ),
          body: screens[cubit.navIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => const TaskScreen(),
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.done), label: done),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: archived),
            ],
          ),
        );
      },
    );
  }
}
