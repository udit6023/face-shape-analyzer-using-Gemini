import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/homeScreen.dart';
import 'package:gemini_app/scanFace.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class GetImages extends StatefulWidget {
  const GetImages({super.key});

  @override
  State<GetImages> createState() => _GetImagesState();
}

class _GetImagesState extends State<GetImages> {
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Set Up Face ID',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey6),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Scan your face to get your face shape',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey2),
            ),
          ),
          const SizedBox(
            height: 135,
          ),
          //  const Spacer(),
          Center(
            child: Lottie.asset('assets/loader.json', height: 300, width: 400),
          ),
          const SizedBox(
            height: 135,
          ),
          Center(
            child: InkWell(
              onTap: () {
                //_pickImages().then((value) => {
                Navigator.push(context, scaleIn(ScanFace()));
                // });
              },
              child: Container(
                width: 250,
                height: 50,
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
                  child: Text('Get Started',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF131313),
                          fontSize: 18)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImages() async {
    ImagePicker _imagePicker = ImagePicker();

    final XFile? _images =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = _images;
    });
  }

  Route scaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
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
