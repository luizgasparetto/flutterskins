import 'package:flutter/material.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

import 'home_page.dart';
import 'products_page.dart';

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
          appBar: AppBar(
            title: const Text('Products'),
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
