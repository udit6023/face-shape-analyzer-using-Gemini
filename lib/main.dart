import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_app/getImages.dart';
import 'package:gemini_app/homeScreen.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized(); //Add this

  await FaceCamera.initialize();

  Gemini.init(apiKey: 'AIzaSyCYikhvl6B1fl3KuQp6o3ovvkKhwHuzLuc');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const GetImages()
    );
  }
}


