import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lojavirtual/controllers/user_controller.dart';
import 'package:lojavirtual/database/auth/auth_service.dart';
import 'package:lojavirtual/widgets/textfield_widget.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'dart:developer' as developer;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  late UserController user;

  @override
  Widget build(BuildContext context) {
    user = context.watch<UserController>();

    loginPage() => Navigator.pop(context);

    register() async {
      try {
        await context.read<AuthService>().registrar(email.text, password.text);
        user.saveName(name.text);
        Navigator.pop(context);
      } on AuthException catch (e, st) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));

        name.text = '';
        email.text = '';
        password.text = '';

        developer.log('', error: e.message.toString(), stackTrace: st);
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 17, 26, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 200),
              child: Text(
                "Create new account",
                style: GoogleFonts.openSans(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                'The best CSGO skins market',
                style: GoogleFonts.openSans(
                  color: const Color.fromRGBO(104, 105, 119, 1),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: name,
                      hintText: 'Name',
                      prefixIconData: IconlyLight.profile,
                      suffixIconData: null,
                      obscureText: false,
                      onChanged: () {},
                    ),
                    const SizedBox(height: 15),
                    TextFieldWidget(
                      controller: email,
                      hintText: 'E-mail',
                      prefixIconData: Icons.mail_outline,
                      suffixIconData: null,
                      obscureText: false,
                      onChanged: () {},
                    ),
                    const SizedBox(height: 15),
                    TextFieldWidget(
                      controller: password,
                      hintText: 'Password',
                      prefixIconData: Icons.lock_outline,
                      suffixIconData: null,
                      obscureText: true,
                      onChanged: () {},
                    ),
                    const SizedBox(height: 20),
                    Ink(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        border: const Border.fromBorderSide(BorderSide.none),
                      ),
                      child: InkWell(
                        onTap: () => register(),
                        borderRadius: BorderRadius.circular(10),
                        child: const SizedBox(
                          height: 60,
                          width: 350,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Ink(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.blueAccent, width: 1)),
                      child: InkWell(
                        onTap: () => loginPage(),
                        borderRadius: BorderRadius.circular(10),
                        child: const SizedBox(
                          height: 60,
                          width: 350,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
