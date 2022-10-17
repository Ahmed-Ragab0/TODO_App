import 'package:flutter/material.dart';
import '../cubit/cubit.dart';

Widget taskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(16.0),
    child:   Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromRGBO(37, 109, 133, 1.0),
      ),
      child:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:  [
             CircleAvatar(

               backgroundColor: const Color.fromRGBO(71, 181, 255, 1.0),
               // fromRGBO(2, 253, 224, 1.0),

              radius: 40.0,

              child: Text(

                '${model['time']}',

                style: const TextStyle(

                  color: Colors.white

                ),

              ),

            ),

            const SizedBox(

              width: 15.0,

            ),

            Expanded(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children:  [

                  Text(

                    '${model['title']}',

                    style: const TextStyle(

                      fontSize: 25.0,

                      fontWeight: FontWeight.bold,

                      color: Colors.white

                    ),

                  ),

                  const SizedBox(

                    height: 6.0,

                  ),

                  Text(

                    '${model['date']}',

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(

                      fontSize: 20.0,

                      color: Colors.grey,

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(

              width: 15.0,

            ),

            IconButton(

                onPressed: (){
                  AppCubit.get(context).updateData(status: 'done', id: model['id']);
                },

                icon: const Icon(

                  Icons.check_circle_outline,

                  color: Colors.white,

                ),

            ),

            IconButton(

                onPressed: (){
                  AppCubit.get(context).updateData(status: 'archive', id: model['id']);
                },

                icon: const Icon(

                  Icons.archive_outlined,

                  color: Colors.white,

                ),

            ),

          ],

        ),
      ),
    ),
  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget doneItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(16.0),
    child:   Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromRGBO(37, 109, 133, 1.0),
      ),
      child:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:  [
             CircleAvatar(

               //rgb(71, 181, 255)
               backgroundColor: const Color.fromRGBO(71, 181, 255, 1.0),
               // fromRGBO(2, 253, 224, 1.0),

              radius: 40.0,

              child: Text(

                '${model['time']}',

                style: const TextStyle(

                  color: Colors.white

                ),

              ),

            ),

            const SizedBox(

              width: 15.0,

            ),

            Expanded(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children:  [

                  Text(

                    '${model['title']}',

                    style: const TextStyle(

                      fontSize: 25.0,

                      fontWeight: FontWeight.bold,

                      color: Colors.white

                    ),

                  ),

                  const SizedBox(

                    height: 6.0,

                  ),

                  Text(

                    '${model['date']}',

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(

                      fontSize: 20.0,

                      color: Colors.grey,

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(

              width: 15.0,

            ),

            IconButton(

                onPressed: (){
                  AppCubit.get(context).updateData(status: 'archive', id: model['id']);
                },

                icon: const Icon(

                  Icons.archive_outlined,

                  color: Colors.white,

                ),

            ),

          ],

        ),
      ),
    ),
  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget archiveItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(16.0),
    child:   Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        //rgb(37, 109, 133)
        color: const Color.fromRGBO(37, 109, 133, 1.0),
      ),
      child:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:  [
             CircleAvatar(

               backgroundColor: const Color.fromRGBO(71, 181, 255, 1.0),
               // fromRGBO(2, 253, 224, 1.0),

              radius: 40.0,

              child: Text(

                '${model['time']}',

                style: const TextStyle(

                  color: Colors.white

                ),

              ),

            ),

            const SizedBox(

              width: 15.0,

            ),

            Expanded(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children:  [

                  Text(

                    '${model['title']}',

                    style: const TextStyle(

                      fontSize: 25.0,

                      fontWeight: FontWeight.bold,

                      color: Colors.white

                    ),

                  ),

                  const SizedBox(

                    height: 6.0,

                  ),

                  Text(

                    '${model['date']}',

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(

                      fontSize: 20.0,

                      color: Colors.grey,

                    ),

                  ),

                ],

              ),

            ),

          ],

        ),
      ),
    ),
  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

