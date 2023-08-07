import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/shared/cubit/states.dart';
import 'package:new_project_flutter/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;


  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> names = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];

  late Database db;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];


  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  //CREATE
  void createDB() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version){
        print('DataBase Created');
        db.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)").then((value) {
          print('Table Created');
        }).catchError((error){
          print('Error when creating table : ${error.toString()}');
        });
      },
      onOpen: (db){
        getFromDB(db);
        print('DataBaseOpened');
      },
    ).then((value) {
      db = value;
      emit(AppCreateDataBaseState());
    });
  }


  //INSERT
   insertInDB({
    required String title,
    required String date,
    required String time,
  }) async
  {
    await db.transaction((txn) {
      txn.rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      ).then((value){
        print('$value inserted successfully');
        emit(AppInsertDataBaseState());

        getFromDB(db);
      }).catchError((error){
        print('Error When inserting new Record : ${error.toString()}');
      });
      return Future(() => null);
    });
  }

  void getFromDB(db) {

    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDataBaseLoadingState());

    db.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element){

        // print(element['status']);
        if(element['status'] == 'new') {
          newTasks.add(element);
        } else if(element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDataBaseState());
    });
    ;
  }

  void updateDB({
  required String status,
  required int id,
}) async {
    await db.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id],
    ).then((value) {
      getFromDB(db);
      emit(AppUpdateDataBaseState());
    });
}

  void deleteFromDB({
    required int id,
  }) async {
    await db.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]
    ).then((value) {
      getFromDB(db);
      emit(AppDeleteDataBaseState());
    });
  }

  void changeBottomSheetState({
    required bool isShown,
    required IconData icon
}){
    isBottomSheetShown = isShown;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
}

bool isDark = false;

void changeTheme({bool? fromShared}){

  if(fromShared != null){
    isDark = fromShared;
    emit(AppChangeThemeModeState());
  }else{
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeThemeModeState());
    });
  }




}


}