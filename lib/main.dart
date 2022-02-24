import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_cubit.dart';
import 'package:todo_app/core/local/sqflite_helper.dart';
import 'package:todo_app/features/layout.dart';
import 'package:todo_app/theme/custom_theme.dart';

import 'blocs/app_bloc/app_states.dart';
import 'blocs/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteHelper.dbInit();

  BlocOverrides.runZoned(
    () => runApp(const TodoApp()),
    blocObserver: MyBlocObserver(),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
            title: 'Todo App',
            debugShowCheckedModeBanner: false,
            theme: CustomTheme.darkTheme(context),
            home: const AppLayout(),
          ),
    );
  }
}
