import 'package:flutter/material.dart';
import 'package:flutter_task/screen1.dart';
import 'package:flutter_task/screen2.dart';
import 'package:flutter_task/screen3.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  runApp(MyApp());
  testWidgets('Tests', (WidgetTester tester) async {
    testRandomDogImageScreen();
    testBluetoothScreen();
    testProfileScreen();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Screens'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RandomDogImageScreen()),
                );
              },
              child: const Text('Random Dog Images'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BluetoothScreen()),
                );
              },
              child: const Text('Enable Bluetooth'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: const Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

void testRandomDogImageScreen() {
  testWidgets('Random Dog Images Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Random Dog Images'));
    await tester.pumpAndSettle();

    expect(find.text('Refresh'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

void testBluetoothScreen() {
  testWidgets('Bluetooth Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Enable Bluetooth'));
    await tester.pumpAndSettle();

    expect(find.text('Enable Bluetooth'), findsOneWidget);
    expect(find.text('Bluetooth is disabled'), findsOneWidget);
  });
}

void testProfileScreen() {
  testWidgets('Profile Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('Name:'), findsOneWidget);
    expect(find.text('Location:'), findsOneWidget);
    expect(find.text('Email:'), findsOneWidget);
    expect(find.text('Date of Birth:'), findsOneWidget);
    expect(find.text('Days Passed Since Registered:'), findsOneWidget);
  });
}

// void main() {
 
// }
