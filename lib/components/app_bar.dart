import 'package:flutter/material.dart';

Widget appBar(context) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(75.0),
      ),
    ),
    height: MediaQuery.of(context).size.height / 5,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'All Notes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        )
      ],
    ),
  );
}