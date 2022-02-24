import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_cubit.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/theme/palette.dart';
import 'package:todo_app/widgets/TextInputField.dart';

import '../blocs/app_bloc/app_states.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  static navTo() => MaterialPageRoute(builder: (context) => const TaskScreen());

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final taskTitle = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final int priority = 0;

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is DBInsertSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              right: 20,
              left: 20,
              top: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInputField(
                  controller: taskTitle,
                  label: 'Task name',
                  icon: Icons.assignment,
                ),
                const SizedBox(height: 10),
                Radio(
                  value: 'Low priority',
                  groupValue: 'groupValue',
                  onChanged: (_) {},
                ),
                Radio(
                  value: 'High ',
                  groupValue: 'groupValue',
                  onChanged: (_) {},
                ),
                state is DBInsertLoading
                    ? const Center(child: CircularProgressIndicator())
                    : MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            cubit
                                .dbInsert(
                                  title: taskTitle.text.trim(),
                                  priority: 1,
                                  type: active,
                                )
                                .then((value) => cubit.dbGetType(type: active));
                          }
                        },
                        color: Theme.of(context).colorScheme.primary,
                        minWidth: MediaQuery.of(context).size.width,
                        child: const Text('Save'),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
