import 'package:flutter/material.dart';

Widget buildBodyBack({required Color color1, required Color color2}) =>
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
