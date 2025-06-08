import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todoadvanced/features/home/viewmodels/home_viewmodel.dart';
import 'package:todoadvanced/features/splash/screens/splash_screen.dart';
import 'package:todoadvanced/features/tasks/viewmodels/task_viewmodel.dart';
import 'package:todoadvanced/data/models/category_model.dart';
import 'package:todoadvanced/data/models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);

  // Register Adapters
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(TaskAdapter());
  
  // Open Boxes
  await Hive.openBox<Category>('categories');
  await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
      ],
      child: MaterialApp(
        title: ' WhatToDo ?',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
