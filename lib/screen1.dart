import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomDogImageScreen extends StatefulWidget {
  @override
  _RandomDogImageScreenState createState() => _RandomDogImageScreenState();
}

class _RandomDogImageScreenState extends State<RandomDogImageScreen> {
  String imageUrl = '';
  final String apiUrl = 'https://dog.ceo/api/breeds/image/random';

  void fetchRandomDogImage() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imageUrl = data['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dog Images'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchRandomDogImage,
              child: Text('Refresh'),
            ),
            SizedBox(height: 20),
            imageUrl.isNotEmpty
                ? Expanded(child: Image.network(imageUrl))
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
