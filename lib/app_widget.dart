

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wakeduino_remote/screens/home_screen.dart';
import 'package:wakeduino_remote/singletons/wakeduino.dart';
import 'package:wakeduino_remote/view/device_list.dart';
import 'package:wakeduino_remote/view/list_items/simple_list_item.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

import '_core/functions.dart';

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      builder: FToastBuilder(),
      title: 'WakeDuino',
        theme: ThemeData(
            primarySwatch: Functions.createMaterialColor(const Color(0xFF0a9ba0))
        ),
      home: HomeScreen()
    );
  }
}

