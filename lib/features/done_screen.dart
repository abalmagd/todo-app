import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/features/empty_screen.dart';

import '../blocs/app_bloc/app_cubit.dart';
import '../blocs/app_bloc/app_states.dart';
import '../widgets/todo_item.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    cubit.dbGetType(type: done);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.doneTasks.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                TodoItem(tasks: cubit.doneTasks[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cubit.doneTasks.length,
          ),
          fallback: (context) => const EmptyScreen(),
        );
      },
    );
  }
}
