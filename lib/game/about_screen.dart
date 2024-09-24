import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        foregroundColor: Colors.deepPurple.shade800,
        backgroundColor: Colors.deepPurple.shade300,
        title: Text(
          "About",
          style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                Icons.logo_dev,
                size: 200,
                color: Colors.deepPurple.shade900,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "VeinDev",
                style: TextStyle(
                    color: Colors.deepPurple.shade900, fontFamily: 'poppins'),
              ),
              Text(
                "Email : tekleeyesus21@gmail.com",
                style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'poppins',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "© 2024",
                style: TextStyle(color: Colors.deepPurple.shade800),
              )
            ],
          ),
        ],
      ),
    );
  }
}
