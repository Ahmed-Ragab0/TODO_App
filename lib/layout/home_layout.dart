import 'package:first/shared/cubit/cubit.dart';
import 'package:first/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AppInsertDatabaseState)
          {
            Navigator.pop(context);
            AppCubit.get(context).taskController.clear();
            AppCubit.get(context).timeController.clear();
            AppCubit.get(context).dateController.clear();
          }
        },
        builder: (context, state) {
          return Scaffold(
            //rgb(6, 40, 61)
            backgroundColor: const Color.fromRGBO(6, 40, 61, 1.0),
            key: AppCubit.get(context).scaffoldKey,
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(6, 40, 61, 1.0),
              title: const Text(
                'Todo App',
              ),
            ),
            body: false
                ? const Center(child: CircularProgressIndicator())
                : AppCubit.get(context).screens[AppCubit.get(context).current],
            bottomNavigationBar: BottomNavigationBar(
              //rgb(71, 181, 255)
              selectedItemColor: const Color.fromRGBO(71, 181, 255, 1.0),
              unselectedItemColor: Colors.grey,
              backgroundColor: const Color.fromRGBO(6, 40, 61, 1.0),
              currentIndex: AppCubit.get(context).current,
              onTap: (index) {
                AppCubit.get(context).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archive',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(71, 181, 255, 1.0),
              onPressed: () {
                // AppCubit.get(context).scaffoldKey.currentState?.showBottomSheet((context) => Container(
                //   color: Colors.red,
                // ));
                if (AppCubit.get(context).showSheet) //false
                {
                  if (AppCubit.get(context).formKey.currentState!.validate()) {

                    AppCubit.get(context).insertIntoDatabase(
                      title: AppCubit.get(context).taskController.text,
                      time: AppCubit.get(context).timeController.text,
                      date: AppCubit.get(context).dateController.text,
                    );
                    //     .then((value) {
                    //   AppCubit.get(context)
                    //       .getDataFromDatabase(AppCubit.get(context).database)
                    //       .then((value) {
                    //     Navigator.pop(context);
                    //     AppCubit.get(context).changeBottomSheetState(isShow: false, icon: Icons.edit);
                    //   });
                    // });
                  }
                } else {
                  AppCubit.get(context).scaffoldKey.currentState?.showBottomSheet(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                      )
                    ),
                        (context) => Container(
                              //rgb(37, 109, 133)
                              color: Colors.white,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: AppCubit.get(context).formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller:
                                            AppCubit.get(context).taskController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'enter the task name';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.title),
                                          label: Text('Task'),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'enter the time';
                                          }
                                          return null;
                                        },
                                        controller:
                                            AppCubit.get(context).timeController,
                                        decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.watch_later_outlined),
                                          label: Text('Time'),
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            AppCubit.get(context)
                                                .timeController
                                                .text = value!.format(context);
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'enter the date';
                                          }
                                          return null;
                                        },
                                        controller:
                                            AppCubit.get(context).dateController,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.calendar_month),
                                          label: Text('Date'),
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                          ).then((value) {
                                            AppCubit.get(context)
                                                    .dateController
                                                    .text =
                                                DateFormat.yMMMd().format(value!);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      )
                      .closed.then((value) {
                    AppCubit.get(context).changeBottomSheetState(isShow: false, icon: Icons.edit);
                  });
                  AppCubit.get(context).changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },

              child: Icon(AppCubit.get(context).floatIcon),
            ),
          );
        },
      ),
    );
  }
}
