import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/homeScreen.dart';

class ScanFace extends StatefulWidget {
  const ScanFace({super.key});

  @override
  State<ScanFace> createState() => _ScanFaceState();
}

class _ScanFaceState extends State<ScanFace> {
  bool isImage = false;
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:CupertinoColors.white,
      body: (isImage == false)
          ? Stack(

            children:[ 
              
              SmartFaceCamera(
                autoCapture: true,
                defaultCameraLens: CameraLens.back,
                indicatorShape: IndicatorShape.square,
               
                showControls: false,
                onFaceDetected: (face) {
                  
                  if (face != null && face.contours.isNotEmpty) {
                    print('face values: ' + face.toString());
                  }
                },
                onCapture: (value) {
                  if (value != null) {
                    setState(() {
                      isImage = true;
                      image = value;
                    });
                    print('face detected' + value.toString());
                  }
                },
               
            
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   SizedBox(
                    height: 70,
                  ),
                    Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Hold Still',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: CupertinoColors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 180.0),
                    child: Text(
                      'While We Do The Magic!!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 60, 60, 71)),
                    ),
                  ),
                ],
              )
              
            ]
          )
          : Stack(
              children: [
                 Image.file(
                  image!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        InkWell(
                          onTap: () {
                            // Navigator.pushReplacement(
                            //     context, scaleIn(HomeScreen(image: image)));
                            setState(() {
                              isImage = false;
                              image = null;
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                              color: Color.fromRGBO(101, 101, 101, 1),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [0.0, 0.8],
                                colors: [
                                  CupertinoColors.systemGrey6,
                                  CupertinoColors.systemGrey2
                                ],
                              ),
                            ),
                            child: const Center(
                                child: Icon(
                              Icons.settings_backup_restore_sharp,
                              size: 25,
                              
                            )),
                          ),
                        ),
                        const SizedBox(width: 30,),
                    
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context, scaleIn(HomeScreen(image: image)));
                            // setState(() {
                            //   isImage = false;
                            //   image = null;
                            // });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                              color: Color.fromRGBO(101, 101, 101, 1),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [0.0, 0.8],
                                colors: [
                                  CupertinoColors.systemGrey6,
                                  CupertinoColors.systemGrey2
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Icon(Icons.check,size: 25,)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               
              ],
            ),
    );
  }

  Route scaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        // var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: page,
        );
      },
    );
  }
}
