import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/controllers/user_controller.dart';
import 'package:lojavirtual/database/auth/auth_service.dart';
import 'package:lojavirtual/myapp.dart';
import 'package:provider/provider.dart';

import 'models/cart_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => UserController(
            auth: context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CartModel(
            auth: context.read<AuthService>(),
          ),
        )
      ],
      child: const MyApp(),
    ),
  );
}
