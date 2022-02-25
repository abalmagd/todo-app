import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_cubit.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/widgets/text_input_field.dart';

import '../blocs/app_bloc/app_states.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TextEditingController taskTitle;
  late final GlobalKey<FormState> _formKey;
  int priority = 2;

  @override
  void initState() {
    taskTitle = TextEditingController();
    _formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    taskTitle.dispose();
    super.dispose();
  }

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
            ),
            child: Padding(
              padding: const EdgeInsets.all(kLargeSpacing),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInputField(
                    controller: taskTitle,
                    label: 'Task name',
                    icon: Icons.assignment,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Low priority'),
                      Radio(
                        value: 0,
                        groupValue: priority,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            priority = value as int;
                          });
                        },
                      ),
                      const Text('High priority'),
                      Radio(
                        value: 1,
                        groupValue: priority,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            priority = value as int;
                          });
                        },
                      ),
                    ],
                  ),
                  if (priority == 2)
                    Center(
                      child: Text(
                        'Choose a priority!',
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    ),
                  state is DBInsertLoading
                      ? const Center(child: CircularProgressIndicator())
                      : MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                priority != 2) {
                              cubit.dbInsert(
                                title: taskTitle.text.trim(),
                                priority: priority,
                                type: active,
                              );
                            }
                          },
                          color: Theme.of(context).colorScheme.primary,
                          minWidth: MediaQuery.of(context).size.width,
                          child: const Text('Save'),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
