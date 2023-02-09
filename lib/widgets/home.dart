// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todoList = [];
  late String _userToDo = '';

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    //initFirebase();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

    todoList.addAll(['Task1', 'Task2']);
  }

  void _menuOpen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('Menu')),
            body: Center(
              child: Column(
                children: [
                  Container(
                    height: 10,
                  ),
                  Text('Simple menu'),
                  ElevatedButton(
                      onPressed: (() {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', ((route) => false));
                      }),
                      child: Text('Return to main screen')),
                ],
              ),
            ));
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TODOLIST'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: _menuOpen,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Text('No data');
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              return Dismissible(
                key: Key(snapshot.data!.docs[index].id),
                child: Card(
                  child: ListTile(
                    title: Text(snapshot.data!.docs[index].get('item')),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('items')
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                      },
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                },
              );
            }),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: Text('Add task'),
                  content: TextField(
                    onChanged: ((value) {
                      _userToDo = '';
                      _userToDo = value;
                    }),
                  ),
                  actions: [
                    TextButton(
                      onPressed: (() {
                        FirebaseFirestore.instance
                            .collection('items')
                            .add({'item': _userToDo});
                        Navigator.of(context).pop();
                      }),
                      child: Text('Add'),
                    )
                  ],
                );
              }));
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
    );
  }
}
