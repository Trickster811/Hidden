import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidden/constants.dart';
import 'package:hidden/main.dart';
import 'package:hidden/screens/start_page.dart';
import 'package:hidden/welcome/auth/sign_in_page.dart';

class LoadingScreen extends StatefulWidget {
  final List<String>? userInfo;
  const LoadingScreen({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // startTime();
    start();
  }

  start() async {
    bool? firstTime = UserSimplePreferences.getFirstTime();
    bool? passwordSecurity = UserSimplePreferences.getPasswordSecurity();
    if (firstTime != null && !firstTime) {
      startTime();
    } else {
      print(firstTime);
      startTime1();
    }
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  startTime1() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route1);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          userInfo: widget.userInfo,
        ),
      ),
    );
  }

  route1() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(
          userInfo: widget.userInfo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 228, 228, 228),
      body: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -MediaQuery.of(context).size.width * 0.8,
          bottom: 0,
          child: Image.asset(
            'assets/images/hidden_icon_logo.png',
            color: Colors.white.withOpacity(0.4),
            // colorBlendMode: BlendMode.modulate,
            // width: MediaQuery.of(context).size.width * 3,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ),
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(
                  'assets/images/hidden_icon_logo.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Hidden Chat',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Comfortaa_bold',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Social Media Network',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Comfortaa_bold',
                    // color: Colors.black45,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
