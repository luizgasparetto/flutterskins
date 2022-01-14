import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  const DrawerTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.controller,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: controller.page == page
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              const SizedBox(width: 32),
              Text(
                text,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: controller.page == page
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
