import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  final File? image;
  const HomeScreen({super.key, required this.image});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final gemini = Gemini.instance;
  bool isLoading = true;

  String res = '';
  bool hav = false;
  var opacityCurve = Interval(0.0, 0.75, curve: Curves.fastLinearToSlowEaseIn);

  @override
  void initState() {
    // TODO: implement initState
    dataFromGemini();
    super.initState();
  }

  dataFromGemini() async {
    gemini.textAndImage(
        text:
            "first work on this,tell the face shape of the human on the basis of these parametrs for each face type and tell only the face without any other text and do not add any unnessary symbols like #,** just Simply Write the title in Upper case add some space before strting with a new point and make that title in uppercase: 1)Oval Face Shape:i)Forehead is slightly wider than the chin ii)Prominent cheekbones iii)Face tapers gently to the chin iv)Suitable for a variety of hairstyles. 2)Round Face Shape: i)Face is nearly as wide as it is long.ii)Soft angles with a rounded chin.iii)Cheekbones are the widest part of the face.iv)Styles with volume on top can add height and elongate the face. 3)Square Face Shape:i)Forehead, cheekbones, and jawline are approximately the same width. ii)Strong, angular jawline.iii)Square chin.iv)Styles with soft layers can soften the angles.4)Heart Face Shape:i)Wide forehead and cheekbones with a narrow jawline and chin.ii)Often a pointed or narrow chin.iii)Styles with volume around the jawline can balance the face.5)Diamond Face Shape:i)Narrow forehead and jawline, with wider cheekbones.ii)Angular jawline.iii)Often a pointed or more angular chin.iv)Styles with volume at the temples and jawline can enhance the cheekbones.6)Rectangular Face Shape:i)Face is longer than it is wide.ii)Straight cheek line and a longer forehead.iii)May have a rounded or square chin.iv)Styles with volume on the sides or bangs can add width.7)Triangular Face Shape:i)Wide forehead that narrows down to a smaller jawline.ii)Pointed or angular chin.iii)Styles with volume at the jawline can balance the face.7)Triangle Face Shape:i)Narrow forehead, wider jawline, and chin.ii)Cheekbones may be less prominent.iii)Styles with volume at the temples can add width to the upper part of the face. And if a person face matches with any given face shapes then thats their face shape and just tell the shape in bold also tell us abt the facial features abt in points and the points which they can improve according to their face shape provide only one point summarise it in tht and if the face shape is oval then check again and give them some specific shape and if the human has a sharp and prominet jawline then say 'You are titled as a Mogger!!'",

        /// text
        images: [
          await widget.image!.readAsBytes(),
        ]

        /// list of images
        ).then((value) {
      setState(() {
        isLoading = false;
        res = value?.content?.parts?.last.text ?? '';
      });
      checkval(res);
      //print(value?.content?.parts ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: (isLoading)
          ? Center(
              child:
                  Lottie.asset('assets/lottie.json', height: 650, width: 650))
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$res',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      (hav == true)
                          ? InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder<void>(
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return AnimatedBuilder(
                                          animation: animation,
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            Future.delayed(Duration(seconds: 5))
                                                .then(
                                              (value) {
                                                Navigator.pop(context);
                                              },
                                            );
                                            return Opacity(
                                                opacity: opacityCurve
                                                    .transform(animation.value),
                                                child: callAward());
                                          });
                                    },
                                  ),
                                );
                                _buildHero(context, '', '');
                              },
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: Lottie.asset('assets/gift.json'),
                              ),
                            )
                          : SizedBox(),
                      Text(
                        'tap me',
                        style: TextStyle(
                            fontSize: 18, color: CupertinoColors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  static Tween<Rect?> _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  Widget _buildHero(
      BuildContext context, String imageName, String description) {
    const opacityCurve =
        Interval(0.0, 0.75, curve: Curves.fastLinearToSlowEaseIn);

    return Container(
      width: 300.0,
      height: 300.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: 'Mogger',
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder<void>(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, Widget? child) {
                        Future.delayed(Duration(seconds: 5)).then(
                          (value) {},
                        );
                        return Opacity(
                            opacity: opacityCurve.transform(animation.value),
                            child: callAward());
                      });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget callAward() {
    return Material(
      color: CupertinoColors.black,
      child: SizedBox(
        height: 50,
        width: 50,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            createRectTween: _createRectTween,
            tag: 'Congrats You are a Mogger!!',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/award.json'),
                const Text(
                  'Mogger!!',
                  style: TextStyle(
                      fontSize: 25,
                      color: CupertinoColors.systemYellow,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkval(String res) {
    bool hav = res.contains('Mogger') || res.contains('MOGGER');
    setState(() {
      hav;
    });
    print(hav);
    // if (hav == true) {
    //   callAward();
    // }
  }
}
