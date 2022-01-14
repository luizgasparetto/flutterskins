import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/views/list_products_page.dart';

class CategorieTile extends StatelessWidget {
  final DocumentSnapshot docSnapshot;

  const CategorieTile({Key? key, required this.docSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(39, 43, 45, 1)),
      child: ListTile(
        title: Center(
          child: Text(
            docSnapshot['title'],
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsPage(snapshot: docSnapshot),
            ),
          );
        },
      ),
    );
  }
}
