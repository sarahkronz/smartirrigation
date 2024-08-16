import 'package:flutter/material.dart';
import 'package:smartirrigation/sensorsreading.dart';
import 'package:smartirrigation/pumpcontroller.dart';
import 'socket_manager.dart';

class actionsList extends StatefulWidget {
  static const String screenRoute = 'actionsList';
  const actionsList({Key? key}) : super(key: key);

  @override
  State<actionsList> createState() => _actionsListState();
}

class _actionsListState extends State<actionsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Actions List '),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Call the function to disconnect from the ESP32
              SocketManager.dispose();
              // Then pop the current screen off the navigation stack
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Color.fromARGB(193, 97, 37, 11),
        body: Stack(children: [
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'images/sungrown-lightdep.jpg',
                ).image,
              ),
            ),
          )),
          Expanded(
              child: Align(
                  alignment: AlignmentDirectional(0, -0.5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(193, 97, 37, 11),
                        side: BorderSide(color: Colors.transparent, width: 1),
                        fixedSize: Size(250, 125)),
                    onPressed: (() {
                      Navigator.pushNamed(context, SensorsReading.screenRoute);
                    }),
                    child: const Text(
                      'Sensors Reading',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 244, 248, 246),
                      ),
                    ),
                  ))),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: Align(
                  alignment: AlignmentDirectional(0.08, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(193, 97, 37, 11),
                        side: BorderSide(color: Colors.transparent, width: 1),
                        fixedSize: Size(250, 125)),
                    onPressed: (() {
                      Navigator.pushNamed(context, pumpcontroller.screenRoute);
                    }),
                    child: const Text(
                      'Pump Test ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 244, 248, 246),
                      ),
                    ),
                  ))),
        ]));
  }
}
