import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'socket_manager.dart';

class SensorsReading extends StatefulWidget {
  static const String screenRoute = 'sensorsreading';
  const SensorsReading({Key? key}) : super(key: key);
  @override
  State<SensorsReading> createState() => _SensorsReadingState();
}

class _SensorsReadingState extends State<SensorsReading> {
  String _soilMoisture = 'Unknown';
  String _humidity = 'Unknown';
  String _temperature = 'Unknown';
  String _airQualityValue = 'Unknown';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
  }

  void _fetchSensorData() {
    setState(() {
      _isLoading = true;
    });
    // Request the latest data from the ESP32

    // Set up the listener for incoming data
    SocketManager.listen((data) {
      final sensorData = jsonDecode(data);
      if (mounted) {
        setState(() {
          _soilMoisture = sensorData['soilMoisture'].toString();
          _humidity = sensorData['humidity'].toString();
          _temperature = sensorData['temperature'].toString();
          _airQualityValue = sensorData['airQualityValue'].toString();
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Reading'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchSensorData, // Refresh the sensor data
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: Colors.grey[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 15.0,
                      percent: (double.tryParse(_soilMoisture) ?? 0) / 1024,
                      center: Text(
                        'SOIL MOISTURE\n$_soilMoisture',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.yellow),
                      ),
                      progressColor: Colors.yellow,
                    ),
                    const SizedBox(height: 60),
                    CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 15.0,
                      percent: (double.tryParse(_temperature) ?? 0) / 100,
                      center: Text(
                        'TEMPERATURE\n$_temperature°C',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      progressColor: Colors.red,
                    ),
                    const SizedBox(height: 60),
                    CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 15.0,
                      percent: (double.tryParse(_humidity) ?? 0) / 100,
                      center: Text(
                        'HUMIDITY\n$_humidity',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      progressColor: Colors.blue,
                    ),
                    const SizedBox(height: 60),
                    CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 15.0,
                      percent: (double.tryParse(_airQualityValue) ?? 0) / 100,
                      center: Text(
                        'airQuality\n$_airQualityValue',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 18, 132, 37)),
                      ),
                      progressColor: Color.fromARGB(255, 22, 111, 44),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
//-----------------------not good version
// import 'dart:convert';
// import 'dart:async';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'socket_manager.dart';

// class SensorsReading extends StatefulWidget {
//   static const String screenRoute = 'sensorsreading';
//   const SensorsReading({Key? key}) : super(key: key);
//   @override
//   State<SensorsReading> createState() => _SensorsReadingState();
// }

// class _SensorsReadingState extends State<SensorsReading> {
//   String _soilMoisture = 'Unknown';
//   String _humidity = 'Unknown';
//   String _temperature = 'Unknown';
//   String _airQualityValue = 'Unknown';
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchSensorData();
//   }

//   void _fetchSensorData() async {
//     try {
//       // Request the latest data from the ESP32

//       SocketManager.listen((data) {
//         final sensorData = jsonDecode(data);
//         setState(() {
//           _soilMoisture = sensorData['soilMoisture'].toString();
//           _humidity = sensorData['humidity'].toString();
//           _temperature = sensorData['temperature'].toString();
//           _airQualityValue = sensorData['airQualityValue'].toString();
//           _isLoading = false;
//         });
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       // Handle the error, possibly by showing an alert dialog
//       _showErrorDialog();
//     }
//   }

//   void _showErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text('Failed to fetch sensor data.'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Retry'),
//             onPressed: () {
//               Navigator.of(context).pop();
//               _fetchSensorData();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sensor Reading'),
//         backgroundColor: Colors.green,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _fetchSensorData, // Refresh the sensor data
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(10),
//                 color: Colors.grey[900],
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     CircularPercentIndicator(
//                       radius: 100,
//                       lineWidth: 15.0,
//                       percent: (double.tryParse(_soilMoisture) ?? 0) / 1024,
//                       center: Text(
//                         'SOIL MOISTURE\n$_soilMoisture',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(color: Colors.yellow),
//                       ),
//                       progressColor: Colors.yellow,
//                     ),
//                     const SizedBox(height: 60),
//                     CircularPercentIndicator(
//                       radius: 100,
//                       lineWidth: 15.0,
//                       percent: (double.tryParse(_temperature) ?? 0) / 100,
//                       center: Text(
//                         'TEMPERATURE\n$_temperature°C',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                       progressColor: Colors.red,
//                     ),
//                     const SizedBox(height: 60),
//                     CircularPercentIndicator(
//                       radius: 100,
//                       lineWidth: 15.0,
//                       percent: (double.tryParse(_humidity) ?? 0) / 100,
//                       center: Text(
//                         'HUMIDITY\n$_humidity',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(color: Colors.blue),
//                       ),
//                       progressColor: Colors.blue,
//                     ),
//                     const SizedBox(height: 60),
//                     CircularPercentIndicator(
//                       radius: 100,
//                       lineWidth: 15.0,
//                       percent: (double.tryParse(_airQualityValue) ?? 0) / 100,
//                       center: Text(
//                         'airQuality\n$_airQualityValue',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                             color: Color.fromARGB(255, 18, 132, 37)),
//                       ),
//                       progressColor: Color.fromARGB(255, 22, 111, 44),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
//--------------------------------------------------the oldest one
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'package:percent_indicator/percent_indicator.dart';
// // Import your SocketManager class here
// import 'socket_manager.dart';

// class SensorsReading extends StatefulWidget {
//   static const String screenRoute = 'sensorsreading';
//   const SensorsReading({Key? key}) : super(key: key);
//   @override
//   State<SensorsReading> createState() => _SensorsReadingState();
// }

// class _SensorsReadingState extends State<SensorsReading> {
//   String _soilMoisture = 'Unknown';
//   String _humidity = 'Unknown';
//   String _temperature = 'Unknown';
//   String _airQualityValue = 'Unknown';

//   @override
//   void initState() {
//     super.initState();
//     // Listen for data from the ESP32
//     SocketManager.listen((data) {
//       final sensorData = jsonDecode(data);
//       setState(() {
//         _soilMoisture = sensorData['soilMoisture'].toString();
//         _humidity = sensorData['humidity'].toString();
//         _temperature = sensorData['temperature'].toString();
//         _airQualityValue = sensorData['airQualityValue'].toString();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sensor Reading'),
//         backgroundColor: Colors.green,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(10),
//           color: Colors.grey[900],
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               CircularPercentIndicator(
//                 radius: 100,
//                 lineWidth: 15.0,
//                 percent: (double.tryParse(_soilMoisture) ?? 0) / 1024,
//                 center: Text(
//                   'SOIL MOISTURE\n$_soilMoisture',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.yellow),
//                 ),
//                 progressColor: Colors.yellow,
//               ),
//               const SizedBox(height: 60),
//               CircularPercentIndicator(
//                 radius: 100,
//                 lineWidth: 15.0,
//                 percent: (double.tryParse(_temperature) ?? 0) / 100,
//                 center: Text(
//                   'TEMPERATURE\n$_temperature°C',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//                 progressColor: Colors.red,
//               ),
//               const SizedBox(height: 60),
//               CircularPercentIndicator(
//                 radius: 100,
//                 lineWidth: 15.0,
//                 percent: (double.tryParse(_humidity) ?? 0) / 100,
//                 center: Text(
//                   'HUMIDITY\n$_humidity',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.blue),
//                 ),
//                 progressColor: Colors.blue,
//               ),
//               const SizedBox(height: 60),
//               CircularPercentIndicator(
//                 radius: 100,
//                 lineWidth: 15.0,
//                 percent: (double.tryParse(_airQualityValue) ?? 0) / 100,
//                 center: Text(
//                   'airQuality\n$_airQualityValue',
//                   textAlign: TextAlign.center,
//                   style:
//                       const TextStyle(color: Color.fromARGB(255, 18, 132, 37)),
//                 ),
//                 progressColor: Color.fromARGB(255, 22, 111, 44),
//               ),
//               // Add other sensors here
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
