import 'package:flutter/material.dart';
// Import your SocketManager class here
import 'socket_manager.dart';

class pumpcontroller extends StatefulWidget {
  static const String screenRoute = 'pumpcontroller';
  const pumpcontroller({Key? key}) : super(key: key);
  @override
  State<pumpcontroller> createState() => _pumpcontrollerState();
}

class _pumpcontrollerState extends State<pumpcontroller> {
  void _sendPumpCommand(String command) {
    // Send command to the ESP32 using the SocketManager
    SocketManager.write(command);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pump Test '),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.green,
        body: Stack(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'images/OIG4.HXjPEUawftz.jpg',
                  ).image,
                ),
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Align(
              alignment: AlignmentDirectional(0.6, 0.77),
              child: ElevatedButton(
                onPressed: () => _sendPumpCommand('1'),
                child: Text('Turn Pump On'),
              ),
            )),
            Expanded(
                child: Align(
              alignment: AlignmentDirectional(-0.6, 0.77),
              child: ElevatedButton(
                onPressed: () => _sendPumpCommand('0'),
                child: Text('Turn Pump Off'),
              ),
            ))
          ],
        ));
  }
}
