import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hidden/constants.dart';
import 'package:hidden/screens/start_page.dart';
import 'package:hidden/welcome/auth/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  final List<String>? userInfo;
  const SignInScreen({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? username;
  authentification(idmat) async {
    // QuerySnapshot querySnapshot;
    List<String> docs = [];
    try {
      FirebaseFirestore.instance
          .collection('User')
          .doc(idmat[0])
          .get()
          .then((DocumentSnapshot doc) async {
        // print(doc.data());

        docs.add(doc['username']);
        docs.add(doc['phone']);
        docs.add(doc['password']);

        // print(docs);

        if (docs[1] == idmat[0] && docs[2] == idmat[1]) {
          await UserSimplePreferences.setUserInfo(docs);
          await UserSimplePreferences.setFirstTime(false);

          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              title: Text(
                'Succes!!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              message: Text(
                'Your informations have been well validated!!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              actions: [
                CupertinoActionSheetAction(
                  // onPressed: () => imageGallerypicker(ImageSource.camera, context),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage(
                          userInfo: widget.userInfo,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              title: Text(
                'Oups!!',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'ArialRoundedBold',
                ),
              ),
              message: Text(
                'Username or password incorrect',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'ArialRoundedBold',
                ),
              ),
              actions: [
                CupertinoActionSheetAction(
                  // onPressed: () => imageGallerypicker(ImageSource.camera, context),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }
      });
      // return 0;
    } catch (e) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(
            'Oups!!',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'ArialRoundedBold',
            ),
          ),
          message: Text(
            'hhfhhfhhhhhhhhhgn',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'ArialRoundedBold',
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              // onPressed: () => imageGallerypicker(ImageSource.camera, context),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Retry'),
            ),
          ],
        ),
      );
      ;
    }
  }

  // Variables to get user entries
  final my_con_1 = TextEditingController();

  final my_con_2 = TextEditingController();

  // Form key
  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Sign In',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      actions: [],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      // appBar: appBar,
      body: Stack(
        children: [
          Positioned(
            right: -MediaQuery.of(context).size.width * 0.8,
            bottom: 0,
            child: Image.asset(
              'assets/images/hidden_icon_logo.png',
              // color: Colors.white,
              // colorBlendMode: BlendMode.modulate,
              // width: MediaQuery.of(context).size.width * 3,
              height: MediaQuery.of(context).size.height * 0.8,
            ),
          ),
          SafeArea(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Platform.isAndroid
                                ? SystemNavigator.pop()
                                : exit(0),
                            icon: SvgPicture.asset(
                              'assets/icons/logout.6.svg',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // Spacer(),
                      Text(
                        'Login into\nyour account',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Form(
                        key: _dropdownFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: 8.0),
                            //   child: Text(
                            //     'Username',
                            //     style: TextStyle(
                            //       color:
                            //           Colors.white,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: TextFormField(
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  icon: SvgPicture.asset(
                                    'assets/icons/call.1.svg',
                                    color: Colors.white,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'enter your phone',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                // value: dropdownvalue_1,
                                controller: my_con_1,
                                onChanged: (text) {},
                                validator: RequiredValidator(
                                  errorText: 'Please enter your phone',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: 8.0),
                            //   child: Text(
                            //     'Password',
                            //     style: TextStyle(
                            //       color:
                            //           Colors.white,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: TextFormField(
                                obscureText: true,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  icon: SvgPicture.asset(
                                    'assets/icons/lock.6.svg',
                                    color: Colors.white,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'enter your password',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                // value: dropdownvalue_1,
                                controller: my_con_2,
                                validator: RequiredValidator(
                                  errorText: 'Please enter your password',
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 50,
                            ),

                            // Submit Button
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.0),
                              child: Container(
                                padding: EdgeInsets.all(12.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10000),
                                ),
                                width: double.maxFinite,
                                child: InkWell(
                                  onTap: () {
                                    if (_dropdownFormKey.currentState!
                                        .validate()) {
                                      final idmat = [
                                        my_con_1.text,
                                        my_con_2.text,
                                      ];
                                      authentification(idmat);
                                    }
                                  },
                                  child: Text(
                                    'Connect',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(5, 35, 61, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New on One Chat?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => SignUpScreen(
                                        userInfo: widget.userInfo,
                                      )),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
