import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/database/auth/auth_service.dart';
import 'package:lojavirtual/database/firestore.dart';
import 'dart:developer' as developer;

class UserController extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;

  UserController({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  saveName(String name) async {
    try {
      db
          .collection('users/${auth.usuario!.uid}/informations')
          .doc('profile')
          .set(
        {
          'name': name,
        },
      );
      notifyListeners();
    } catch (e, st) {
      developer.log(
        'Erro ao setar o nome do usuário: ${auth.usuario!.uid}',
        error: e.toString(),
        stackTrace: st,
      );
    }
  }

  Future<String> getName() async {
    final user = await db
        .collection('users/${auth.usuario!.uid}/informations')
        .doc('profile')
        .get();

    return user.get('name');
  }
}
