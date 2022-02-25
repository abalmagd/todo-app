import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/app_bloc/app_states.dart';
import 'package:todo_app/core/local/sqflite_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  int navIndex = 0;
  List activeTasks = [];
  List archivedTasks = [];
  List doneTasks = [];

  void changeNavIndex({required int index}) {
    navIndex = index;
    emit(ChangeNavigation());
  }

  void dbGetType({required String type}) {
    emit(DBGetTypeLoading());
    SqfliteHelper.dbGetType(type: type).then((value) {
      type == 'Active'
          ? activeTasks = value
          : type == 'Done'
              ? doneTasks = value
              : archivedTasks = value;
      debugPrint('DB get $type tasks => #${activeTasks.length} task');
      emit(DBGetTypeSuccess());
    }).catchError((error) {
      debugPrint('DB get $type failed => $error');
      emit(DBGetTypeFailed());
    });
  }

  void dbInsert({
    required String title,
    required int priority,
    required String type,
  }) {
    emit(DBInsertLoading());
    SqfliteHelper.dbInsert(
      title: title,
      priority: priority,
      type: type,
    ).then(
      (value) {
        emit(DBInsertSuccess());
        dbGetType(type: type);
      },
    ).catchError(
      (error) {
        debugPrint('DB Insert $type failed => $error');
        emit(DBInsertFailed());
      },
    );
  }

  void dbDelete({
    required int id,
    required String type,
  }) {
    emit(DBDeleteLoading());
    SqfliteHelper.dbDelete(id).then(
      (value) {
        emit(DBDeleteSuccess());
        dbGetType(type: type);
        debugPrint('DB delete id => #$id');
      },
    ).catchError(
      (error) {
        debugPrint('DB delete id  #$id failed => $error');
        emit(DBDeleteFailed());
      },
    );
  }

  void dbUpdate({
    required int id,
    required String typeTo,
    required String typeFrom,
  }) {
    emit(DBUpdateLoading());
    SqfliteHelper.dbUpdate(typeTo, id).then(
      (value) {
        emit(DBUpdateSuccess());
        dbGetType(type: typeFrom);
        debugPrint('DB update id => #$id');
      },
    ).catchError(
      (error) {
        debugPrint('DB update id  #$id failed => $error');
        emit(DBUpdateFailed());
      },
    );
  }
}
