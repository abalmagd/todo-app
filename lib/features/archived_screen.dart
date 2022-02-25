import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app_bloc/app_cubit.dart';
import '../blocs/app_bloc/app_states.dart';
import '../core/constants.dart';
import '../widgets/todo_item.dart';
import 'empty_screen.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    cubit.dbGetType(type: archived);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.archivedTasks.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                TodoItem(tasks: cubit.archivedTasks[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cubit.archivedTasks.length,
          ),
          fallback: (context) => const EmptyScreen(),
        );
      },
    );
  }
}
