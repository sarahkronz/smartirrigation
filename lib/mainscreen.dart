import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartirrigation/actionslist.dart';
import 'socket_manager.dart';

class mainscreen extends StatefulWidget {
  static const String screenRoute = 'mainscreen';
  const mainscreen({Key? key}) : super(key: key);
  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  void _connectToESP32() async {
    // Call the function to establish the connection with the ESP32
    await SocketManager.connectToESP32();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF7A8B97),
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
                      'images/_54c40fcb-68c4-43c5-ad26-2f585615c822.jpeg',
                    ).image,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Expanded(
                child: Align(
                    alignment: AlignmentDirectional(0, 0.69),
                    child: Text(
                      'Smart Irrigation System',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 22, 109, 61),
                      ),
                      textAlign: TextAlign.center,
                      selectionColor: Color(0xFF166D33),
                    ))),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Align(
                    alignment: AlignmentDirectional(0.02, 0.9),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 22, 109, 51),
                        side: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      onPressed: (() {
                        _connectToESP32();
                        Navigator.pushNamed(context, actionsList.screenRoute);
                      }),
                      child: const Text(
                        'start...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 244, 248, 246),
                        ),
                      ),
                    )))
          ], //children
        ));
  }
}
