import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/data/ProductData.dart';
import 'package:lojavirtual/views/product_page.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  const ProductTile({Key? key, required this.type, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == 'grid'
        ? InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductPage(product: product)));
            },
            child: Container(
              width: 200,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromRGBO(57, 63, 71, 0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: FadeInImage.memoryNetwork(
                      width: 300,
                      height: 130,
                      fit: BoxFit.contain,
                      placeholder: kTransparentImage,
                      image: product.images[0],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 17,
                    child: Text(
                      '${product.status} | ${product.float}',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 20,
                    child: Text(
                      '\$ ${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductPage(product: product)));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromRGBO(57, 63, 71, 0.2),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.contain,
                      height: 250,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 25,
                          child: Text(
                            '${product.status} | ${product.float}',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 28,
                          child: Text(
                            '\$ ${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.montserrat(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
