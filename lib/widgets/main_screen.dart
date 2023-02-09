// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('TODOLIST'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: 10,
              ),
              Text(
                'Main Screen',
                style: TextStyle(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context,
                  //     '/todo'); // открывает новую страницу поверх предыдущей и позволяет вернуться назад
                  Navigator.pushReplacementNamed(context,
                      '/todo'); // закрывает первый экран полностью и оставляет только второй
                },
                child: Text('List Tasks'),
              ),
            ],
          ),
        ));
  }
}
