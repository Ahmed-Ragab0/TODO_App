import 'package:first/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/archived_tasks/archived_tasks.dart';
import '../../modules/done_tasks/done_tasks.dart';
import '../../modules/new_tasks/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  int current = 0;
  bool showSheet = false;
  IconData floatIcon = Icons.edit;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var timeController = TextEditingController();
  var taskController = TextEditingController();
  var dateController = TextEditingController();


  void changeIndex(int index) {
    current = index;
    emit(AppChangeBottomNavBar());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('database created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          debugPrint('table created');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        debugPrint('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertIntoDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) {
      txn.rawInsert(
              'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        debugPrint('$value inserted success');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((onError) {
        debugPrint('error ${onError.toString()}');
      });
      return Future(() => null);
    });
  }

  void getDataFromDatabase(database)  {

    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element) {

        if(element['status'] == 'new')
        {
          newTasks.add(element);
        }else if(element['status'] == 'done')
        {
          doneTasks.add(element);
        }else
        {
          archiveTasks.add(element);
        }

      });
      emit(AppGetDatabaseState());
    });
  }
  
  void updateData({
  required String status,
  required int id,
})
  {
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(UpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  })
  {
    database?.rawDelete('DELETE FROM tasks WHERE id = ?',
        [id]
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }

  void changeBottomSheetState({
    required isShow,
    required icon,
  })
  {
    showSheet = isShow;
    floatIcon = icon;
    emit(AppShowSheetState());
  }
}