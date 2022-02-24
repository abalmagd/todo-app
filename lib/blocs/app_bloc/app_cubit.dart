import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_states.dart';
import 'package:todo_app/core/local/sqflite_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  int navIndex = 0;
  List activeTasks = [];
  List doneTasks = [];
  List archivedTasks = [];
  List trashTasks = [];

  void changeNavIndex({required int index}) {
    navIndex = index;
    emit(ChangeNavigation());
  }

  void dbGetType({required String type}) {
    emit(DBGetTypeLoading());
    SqfliteHelper.dbGetType(type: type).then((value) {
      activeTasks = value;
      debugPrint('Last element in ${activeTasks.last}');
      emit(DBGetTypeSuccess());
    }).catchError((error) {
      debugPrint('DB Get $type failed => $error');
      emit(DBGetTypeFailed());
    });
  }

  void dbInsert({
    required String title,
    required int priority,
    required String type,
  }) {
    emit(DBInsertLoading());
    try {
      SqfliteHelper.dbInsert(title: title, priority: priority, type: type);
      emit(DBInsertSuccess());
    } catch (error) {
      debugPrint('DB Insert $type failed => $error');
      emit(DBInsertFailed());
    }
  }
}
