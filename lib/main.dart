import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqlite_flutter_crud/Authtentication/login.dart';
import 'package:sqlite_flutter_crud/Views/best.dart';
import 'package:sqlite_flutter_crud/Views/commande.dart';
import 'package:sqlite_flutter_crud/Views/menu.dart';
import 'package:sqlite_flutter_crud/Views/notes.dart';
import 'package:sqlite_flutter_crud/Views/start.dart';
import 'package:sqlite_flutter_crud/Views/support.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Start(),
      routes: {
        '/best': (context) => BestPage(),
        '/menu': (context) => MenuPage(),
        '/support': (context) => SupportPage(),
        '/login': (context) => LoginScreen(),
       // '/note': (context) => Notes(),
       // '/commande': (context) => CommandePage(),



      },
    );
  }
}
