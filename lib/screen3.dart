import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};
  String? image;
  Future<void> fetchRandomUserProfile() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        userData = data['results'][0];
        image = '${userData['picture']['medium']}'.toString();
      });
    }
  }

  String calculateDaysPassed(String registeredDate) {
    final registrationDate = DateTime.parse(registeredDate);
    final currentDate = DateTime.now();
    final daysPassed = currentDate.difference(registrationDate).inDays;
    return daysPassed.toString();
  }

  @override
  void initState() {
    super.initState();
    fetchRandomUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: userData.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Image.network(
                      image!,
                      scale: 1,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Text('Error loading image');
                      },
                    ),
                  ),
                  // CircleAvatar(
                  //   foregroundColor: Colors.transparent,
                  //   backgroundImage: NetworkImage(image!),
                  //   radius: 50,
                  // ),
                  const SizedBox(height: 20),
                  Text(
                      'Name: ${userData['name']['first']} ${userData['name']['last']}'),
                  const SizedBox(height: 20),
                  Text(
                      'Location: ${userData['location']['city']}, ${userData['location']['state']}'),
                  const SizedBox(height: 20),
                  Text('Email: ${userData['email']}'),
                  const SizedBox(height: 20),
                  Text('Date of Birth: ${userData['dob']['date']}'),
                  const SizedBox(height: 20),
                  Text(
                      'Days Passed Since Registered: ${calculateDaysPassed(userData['registered']['date'])}'),
                ],
              ),
      ),
    );
  }
}
