import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  bool isBluetoothEnabled = false;
  static const MethodChannel _channel = MethodChannel('bluetooth_channel');

  Future<void> enableBluetooth() async {
    try {
      final bool result = await _channel.invokeMethod('enableBluetooth');
      if (result) {
        setState(() {
          isBluetoothEnabled = true;
        });
      }
    } on PlatformException catch (e) {
      print('Failed to enable Bluetooth: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isBluetoothEnabled ? null : enableBluetooth,
              child: const Text('Enable Bluetooth'),
            ),
            const SizedBox(height: 20),
            Text(
              isBluetoothEnabled
                  ? 'Bluetooth is enabled'
                  : 'Bluetooth is disabled',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
