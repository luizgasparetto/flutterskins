import 'package:flutter/material.dart';
import 'package:lojavirtual/database/auth/auth_check.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter's Skins",
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        hintColor: const Color.fromRGBO(130, 87, 229, 1),
      ),
    );
  }
}
