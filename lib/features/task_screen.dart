import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_cubit.dart';
import 'package:todo_app/core/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new task'),
      ),
      body: SafeArea(
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is DBInsertSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextInputField(
                          controller: taskTitle,
                          label: 'Task name',
                          icon: Icons.assignment,
                        ),
                        const SizedBox(height: 10),
                        state is DBInsertLoading
                            ? const Center(child: CircularProgressIndicator())
                            : MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.dbInsert(
                                      title: taskTitle.text.trim(),
                                      priority: 1,
                                      type: active,
                                    );
                                  }
                                },
                                child: const Text('Save'),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
