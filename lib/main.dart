import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/note_app/Note_App.dart';

import 'note_app/hive_helper.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox(HiveHelper.nameBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  NoteApp(),
      debugShowCheckedModeBanner: false,

    );
  }
}

