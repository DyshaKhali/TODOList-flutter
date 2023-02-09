// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_list_todo/widgets/home.dart';
import 'package:flutter_list_todo/widgets/main_screen.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/todo': (context) => Home(),
      },
    ));
