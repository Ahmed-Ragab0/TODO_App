import 'package:first/modules/counter/cubit/cubit.dart';
import 'package:first/modules/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>
        (
        listener: (context, state) {} ,
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text('counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: const Text(
                        'minus',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      )),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: const Text(
                        'plus',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}




