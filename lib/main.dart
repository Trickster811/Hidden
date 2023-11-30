// ************************************************************
// ************************************************************
// ***     Copyright 2022 One Chat. All rights reserved.    ***
// ***          by Jo@chim Ned@ouk@ (MacNight_nj).          ***
// ************************************************************
// ************************************************************

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidden/constants.dart';
import 'package:hidden/welcome/loading_page.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  // onConnection(socket);

  // await Hive.initFlutter();
  await UserSimplePreferences.init();
  ThemeProvider.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<String>? userInfo;

  @override
  void initState() {
    super.initState();
    // startConnection();
    userInfo = UserSimplePreferences.getUserInfo();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          // builder: (context, child) => StreamChat(
          //   client: widget.client,
          //   child: child,
          // ),
          title: 'One Chat',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: LoadingScreen(
            userInfo: userInfo,
          ),
        );
      },
    );
  }
}
