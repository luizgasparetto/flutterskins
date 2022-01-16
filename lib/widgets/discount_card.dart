import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/widgets/textfield_widget.dart';
import 'package:provider/src/provider.dart';

class DiscountCard extends StatefulWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  _DiscountCardState createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {
  final coupon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartModel>();

    return Card(
      elevation: 1,
      color: const Color.fromRGBO(22, 27, 34, 0.6),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        collapsedIconColor: const Color.fromRGBO(255, 255, 255, 1),
        iconColor: const Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          'Apply your discount coupon',
          style: GoogleFonts.montserrat(
            color: const Color.fromRGBO(255, 255, 255, 0.9),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.start,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: coupon,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your discount coupon',
                hintStyle: const TextStyle(color: Colors.blueAccent),
                prefixIcon: const Icon(
                  Icons.card_giftcard,
                  size: 18,
                  color: Colors.blueAccent,
                ),
                filled: true,
                fillColor: const Color.fromRGBO(104, 105, 119, 0.15),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                labelStyle: const TextStyle(color: Colors.blueAccent),
                focusColor: Colors.blueAccent,
              ),
              onFieldSubmitted: (text) {
                if (text.isEmpty) {
                  cart.setCupom(null, 0);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Non coupon"),
                  ));
                  return;
                }

                FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(text)
                    .get()
                    .then(
                      (docCoupon) => {
                        if (docCoupon.exists)
                          {
                            cart.setCupom(text, docCoupon['percent']),
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Coupon applied successfully'),
                            ))
                          }
                        else
                          {
                            cart.setCupom(null, 0),
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Coupon doesn't exists!"),
                            ))
                          }
                      },
                    );
              },
            ),
          )
        ],
      ),
    );
  }
}
