import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/components.dart';
import 'package:flutter_application_1/views/livedetection.dart';
import 'package:flutter_application_1/views/report.dart';
import 'package:flutter_application_1/views/viewpot.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
        title: const Text('Home Page'),
      ),
      body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Please Select the Options Below',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Button(
                text: 'Report Pot-Hole',
                color: Colors.purple.shade900,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportPotholeView()));
                }),
            const SizedBox(height: 20),
            Button(
                text: 'View Pot-Hole Areas',
                color: Colors.purple.shade900,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPotholeView()));
                }),
            const SizedBox(
              height: 20,
            ),
            Button(
                text: 'Live-Detection',
                color: Colors.purple.shade900,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ObjectDetectionScreen()));
                }),
          ]),
    );
  }
}
