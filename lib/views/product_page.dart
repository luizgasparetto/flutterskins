import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/data/ProductData.dart';
import 'package:lojavirtual/data/cart_product.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/views/cart_screen.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'dart:developer' as dev;

class ProductPage extends StatefulWidget {
  final ProductData product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final ProductData product = widget.product;
    final cart = context.read<CartModel>();
    dev.log(product.id, name: 'lufuss');

    return Scaffold(
      backgroundColor: const Color.fromRGBO(23, 22, 31, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          product.images.length > 1
              ? Container(
                  margin: const EdgeInsets.all(24),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Carousel(
                      images: product.images
                          .map((image) => NetworkImage(image))
                          .toList(),
                      showIndicator: true,
                      dotSize: 4,
                      dotSpacing: 15,
                      dotColor: Colors.white,
                      dotBgColor: Colors.transparent,
                      dotIncreasedColor: const Color.fromRGBO(130, 87, 229, 1),
                      overlayShadowColors: Colors.blue,
                      autoplay: false,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(24),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.network(product.images[0]),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(255, 255, 255, 0.9),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Text(
                  '${product.status} | ${product.float}',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(255, 255, 255, 0.9),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                Text(
                  '\$ ${product.price.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.26,
                    ),
                    children: product.tags
                        .map(
                          (tag) => GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: color(),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                tag,
                                style: GoogleFonts.montserrat(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 32),
                Ink(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(68, 138, 255, 0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent, width: 1)),
                  child: InkWell(
                    onTap: () async {
                      final itens = await cart.getCarItems();
                      bool valid = true;

                      for (var cartItem in itens.docs) {
                        if (cartItem['productId'] == product.id) {
                          setState(() {
                            valid = false;
                          });
                        }
                      }

                      if (valid) {
                        CartProduct cartProduct = CartProduct();
                        cartProduct.quantity = 1;
                        cartProduct.productId = product.id;
                        cartProduct.category = product.category;

                        cart.addCarItem(cartProduct);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartScreen()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Pedido não processado, item já está no carrinho')));
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: const SizedBox(
                      height: 60,
                      width: 350,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add to cart',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color color() {
    if (widget.product.type == 'covert') return Colors.yellow;
    if (widget.product.type == 'extraordinary') return Colors.red;
    if (widget.product.type == 'classified') return Colors.pinkAccent;
    return Colors.purpleAccent;
  }
}
