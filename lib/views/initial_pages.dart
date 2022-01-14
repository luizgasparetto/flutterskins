import 'package:flutter/material.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

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
          body: const HomePage(),
          drawer: CustomDrawer(
            pageController: _pageController,
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
