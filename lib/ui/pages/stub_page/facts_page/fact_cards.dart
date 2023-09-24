import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String title;
  final String fact;

  const Cards({super.key, required this.title, required this.fact});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.grey.shade900),
            ),
            Text(
              fact,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
