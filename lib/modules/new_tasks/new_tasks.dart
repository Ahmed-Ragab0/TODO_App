import 'package:first/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/component.dart';
import '../../shared/cubit/cubit.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          return ListView.separated(
            itemBuilder: (context, index) => taskItem(AppCubit.get(context).newTasks[index], context),
            separatorBuilder: (context, index) => const Padding(
              padding:  EdgeInsetsDirectional.only(
                  start: 20.0
              ),
              child:SizedBox(
                height: 1.0,
              )
            ),
            itemCount: AppCubit.get(context).newTasks.length,
          );
        },
    );
  }
}
