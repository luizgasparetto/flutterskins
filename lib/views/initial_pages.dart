import 'package:flutter/material.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

import 'cart_screen.dart';
import 'home_page.dart';
import 'categories_page.dart';

class ViewPage extends StatelessWidget {
  ViewPage({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          backgroundColor: const Color.fromRGBO(23, 22, 31, 1),
          body: const HomePage(),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Popularity Skins "),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen())),
                icon: const Icon(
                  Icons.shopping_cart,
                ),
              )
            ],
          ),
        ),
        Scaffold(
          backgroundColor: const Color.fromRGBO(23, 22, 31, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(23, 22, 31, 1),
            title: const Text('Categories'),
            centerTitle: true,
            elevation: 0,
          ),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
          body: const ProductsPage(),
        ),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
      ],
    );
  }
}
