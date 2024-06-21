import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor/src/view/screen/register.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset('assets/images/profile_pic.png')),
          const Text(
            "Hello Sina!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/github.png', width: 60),
              const SizedBox(width: 10),
              const Text(
                "https://github.com/SinaSys",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // Navigate to the login screen or any other screen you want
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginRegisterScreen()),
              );
            },
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
