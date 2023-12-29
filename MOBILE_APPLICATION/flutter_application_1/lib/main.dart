import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/views/livedetection.dart';
import 'package:flutter_application_1/views/onbording.dart';
import 'package:provider/provider.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DetectedObjectsProvider()),
      ],
      child: const MaterialApp(
        title: 'Object Detection App',
        debugShowCheckedModeBanner: false,
        // home: ObjectDetectionScreen(),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Onbording(),
          ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A148C),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 300,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            width: double.infinity,
            child: Image.asset('./assets/logo.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            'POTHOLE DETECTION and REPORTING SYSTEM',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    );
  }
}
