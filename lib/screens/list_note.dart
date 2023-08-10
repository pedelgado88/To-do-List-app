import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/manage_bloc.dart';

import '../model/notes.dart';

import '../bloc/monitor_bloc.dart';

class ListNote extends StatelessWidget {
  ListNote({Key? key}) : super(key: key);

  final List colors = [Colors.orange, Colors.red, Colors.yellow];
  final List icons = [Icons.assignment_outlined, Icons.assignment_outlined];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(
      builder: (context, state) => getNoteListView(state.noteCollection),
    );
  }

  ListView getNoteListView(NoteCollection noteCollection) {
    if (noteCollection.length() == 0) {
      return ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromARGB(255, 51, 176, 222)),
            height: 50,
            child: const Center(child: Text('Você não possui tarefas a serem realizadas', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))),
          ),
 
        ],
      );
    } else {
      return ListView.builder(
          itemCount: noteCollection.length(),
          itemBuilder: (context, position) => ListTile(
                onTap: () {
                  //print(noteCollection.getIdAtIndex(position));
                  //BlocProvider.of<ManageBloc>(context).add(UpdateRequest(
                  //  noteId: noteCollection.getIdAtIndex(position),
                  //  previousNote: noteCollection.getNoteAtIndex(position),
                 // ));
                },
                leading: Icon(icons[position % icons.length]),
                trailing: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ManageBloc>(context).add(DeleteEvent(
                          noteId: noteCollection.getIdAtIndex(position)));
                    },
                    child: const Icon(Icons.check)),
                title: Text(noteCollection.getNoteAtIndex(position).title),
                subtitle:
                    Text(noteCollection.getNoteAtIndex(position).description),
              ));
    }
  }
}
