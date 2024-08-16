// socket_manager.dart
import 'dart:io';
import 'dart:async';
import 'dart:convert';

typedef DataListenerCallback = void Function(String data);

class SocketManager {
  static Socket? _socket;
  static final List<DataListenerCallback> _listeners = [];

  static Future<void> connectToESP32() async {
    try {
      _socket = await Socket.connect('192.168.4.1', 23);
      _socket!.listen(
        (List<int> data) {
          final serverResponse = utf8.decode(data);
          // Notify all listeners with the new data
          for (var listener in _listeners) {
            listener(serverResponse);
          }
        },
        onError: (error) {
          print('Error: $error');
          dispose();
        },
        onDone: () {
          print('Server left.');
          dispose();
        },
      );
      _socket!.write('GET /sensor-data');
    } catch (e) {
      print('Failed to connect to ESP32: $e');
    }
  }

  static void write(String message) {
    _socket?.write(message);
  }

  static void listen(DataListenerCallback listener) {
    _listeners.add(listener);
  }

  static void dispose() {
    _socket?.destroy();
    _socket = null;
    _listeners.clear();
  }
}
