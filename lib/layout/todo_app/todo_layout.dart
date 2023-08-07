import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_project_flutter/shared/components/components.dart';
import 'package:new_project_flutter/shared/components/constants.dart';
import 'package:new_project_flutter/shared/cubit/cubit.dart';
import 'package:new_project_flutter/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is AppInsertDataBaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, Object? state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.names[cubit.currentIndex],
              ),
            ),
            body: state is! AppGetDataBaseLoadingState ? cubit.screens[cubit.currentIndex] : Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    cubit.insertInDB(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text
                    );
                  }
                }else{
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormFeild(
                                controller: titleController,
                                type: TextInputType.text,
                                validate: (String value){
                                  if(value.isEmpty){
                                    return 'title must not be empty';
                                  }
                                  return null;
                                },
                                label: 'Title',
                                prefix: Icons.title
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormFeild(
                                controller: timeController,
                                type: TextInputType.datetime,
                                validate: (String value){
                                  if(value.isEmpty){
                                    return 'Time must not be empty';
                                  }
                                  return null;
                                },
                                onTap: (){
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now()
                                  ).then((value){
                                    timeController.text = value!.format(context).toString();
                                  });
                                },
                                label: 'Time',
                                prefix: Icons.watch_later_outlined
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormFeild(
                                controller: dateController,
                                type: TextInputType.datetime,
                                validate: (String value){
                                  if(value.isEmpty){
                                    return 'Date must not be empty';
                                  }
                                  return null;
                                },
                                onTap: (){
                                  showDatePicker(context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse("2023-09-25"),
                                  ).then((value) {
                                    dateController.text = DateFormat().add_yMMMd().format(value!);
                                  });
                                },
                                label: 'Date',
                                prefix: Icons.calendar_today_outlined
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 30.0,
                  ).closed.then((value) {
                   cubit.changeBottomSheetState(isShown: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShown: true, icon: Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 50.0,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.menu
                  ),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.check_circle_outline
                  ),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.archive_outlined
                  ),
                  label: "Archived",
                ),
              ],
            ),
          );
        },

      ),
    );
  }

}
