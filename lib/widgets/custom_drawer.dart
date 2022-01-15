import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/controllers/user_controller.dart';
import 'package:lojavirtual/database/auth/auth_service.dart';
import 'package:lojavirtual/widgets/text.dart';
import 'package:lojavirtual/widgets/tiles/background_gradient.dart';
import 'package:lojavirtual/widgets/tiles/drawer_tile.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  const CustomDrawer({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userAuth = context.watch<AuthService>();
    final user = context.read<UserController>();

    return Container(
      color: const Color.fromRGBO(23, 22, 31, 1),
      padding: const EdgeInsets.only(top: 129),
      child: Drawer(
        child: Stack(
          children: [
            buildBodyBack(
              color1: const Color.fromRGBO(23, 22, 31, 1),
              color2: const Color.fromRGBO(13, 17, 23, 1),
            ),
            ListView(
              padding: const EdgeInsets.only(left: 32, top: 16),
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.fromLTRB(0, 32, 16, 8),
                  height: 220,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 12,
                        left: 0,
                        child: buildTitle("Flutter's\nSkins", size: 34),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                buildTitle('Olá, ', size: 18),
                                const SizedBox(height: 3),
                                FutureBuilder(
                                  future: user.getName(),
                                  builder: (context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        style: GoogleFonts.montserrat(
                                          color: Colors.blueAccent,
                                          fontSize: 19,
                                        ),
                                      );
                                    } else {
                                      return const Text('Loading...');
                                    }
                                  },
                                ),
                                IconButton(
                                  onPressed: () async =>
                                      await userAuth.logout(),
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                DrawerTile(
                  icon: Icons.home,
                  text: 'Home',
                  controller: pageController,
                  page: 0,
                ),
                DrawerTile(
                  icon: Icons.list,
                  text: 'Categories',
                  controller: pageController,
                  page: 1,
                ),
                DrawerTile(
                  icon: Icons.location_on,
                  text: 'Stores',
                  controller: pageController,
                  page: 2,
                ),
                DrawerTile(
                  icon: Icons.playlist_add_check,
                  text: 'Orders',
                  controller: pageController,
                  page: 3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
