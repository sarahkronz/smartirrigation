import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartirrigation/actionsList.dart';
import 'package:smartirrigation/mainscreen.dart';
import 'package:smartirrigation/pumpcontroller.dart';
import 'package:smartirrigation/sensorsreading.dart';
import 'package:smartirrigation/socket_manager.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'smart irrigation system',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 113, 46)),
          useMaterial3: true,
        ),
        initialRoute: mainscreen.screenRoute,
        routes: {
          mainscreen.screenRoute: (context) => const mainscreen(),
          actionsList.screenRoute: (context) => const actionsList(),
          SensorsReading.screenRoute: (context) => const SensorsReading(),
          pumpcontroller.screenRoute: (context) => const pumpcontroller(),
        });
  }
}
