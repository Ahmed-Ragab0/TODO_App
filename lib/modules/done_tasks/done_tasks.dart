import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/component.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return ListView.separated(
          itemBuilder: (context, index) => doneItem(AppCubit.get(context).doneTasks[index], context),
          separatorBuilder: (context, index) => const Padding(
              padding:  EdgeInsetsDirectional.only(
                  start: 20.0
              ),
              child:SizedBox(
                height: 1.0,
              )
          ),
          itemCount: AppCubit.get(context).doneTasks.length,
        );
      },
    );
  }
}
