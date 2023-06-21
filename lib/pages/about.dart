import 'dart:html';

import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quotes App By Kelompok 6",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text("Rendi Alinurding - 2006030"),
            Text("Rifki Ardiansyah - 2006031"),
            Text("Mochamad Riefky Rafliana Suwandy - 2006085"),
          ],
        ),
      ),
    );
  }
}
