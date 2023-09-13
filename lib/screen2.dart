import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  static const platform = MethodChannel('bluetooth_native');
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isBluetoothEnabled = false;

  Future<void> enableBluetooth() async {
    try {
      final bool result = await platform.invokeMethod('enableBluetooth');
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
        title: Text('Bluetooth Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isBluetoothEnabled ? null : enableBluetooth,
              child: Text('Enable Bluetooth'),
            ),
            SizedBox(height: 20),
            Text(
              isBluetoothEnabled
                  ? 'Bluetooth is enabled'
                  : 'Bluetooth is disabled',
              style: TextStyle(
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
