import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/database/auth/auth_service.dart';
import 'package:lojavirtual/views/register_page.dart';
import 'package:lojavirtual/widgets/textfield_widget.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'dart:developer' as developer;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();

    registerPage() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegisterPage()));
    }

    login() async {
      try {
        await auth.login(email.text, password.text);
      } on AuthException catch (e, st) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
          ),
        );
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
                'Welcome Back!',
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
                "We're happy to see you again",
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (email.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Plese enter an e-mail to recover your password'),
                              ),
                            );
                          } else {
                            auth.recoverPassword(email.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Check your e-mail to recover your password'),
                              ),
                            );
                          }
                        },
                        child: const Text('Forgot your password?'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Ink(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        border: const Border.fromBorderSide(BorderSide.none),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) login();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: const SizedBox(
                          height: 60,
                          width: 350,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
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
                        onTap: () => registerPage(),
                        borderRadius: BorderRadius.circular(10),
                        child: const SizedBox(
                          height: 60,
                          width: 350,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Register',
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
