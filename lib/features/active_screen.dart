import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_cubit.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/features/empty_screen.dart';
import 'package:todo_app/widgets/todo_item.dart';

import '../blocs/app_bloc/app_states.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    cubit.dbGetType(type: active);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.activeTasks.isNotEmpty,
          builder: (context) =>
              ListView.separated(
                itemBuilder: (context, index) =>
                    TodoItem(tasks: cubit.activeTasks[index]),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: cubit.activeTasks.length,
              ),
          fallback: (context) => const EmptyScreen(),
        );
      },
    );
  }
}
