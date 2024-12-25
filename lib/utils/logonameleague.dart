import 'package:finalproject/widgets/customtext';
import 'package:flutter/material.dart';

logoNameLeague({required String logo, required String name}) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.network(
          logo,
          height: 35,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      const SizedBox(width: 30),
      CustomText(
        text: name,
        isBold: false,
        colours: 0xFFFFFFFF,
        fontSize: 15,
      )
    ],
  );
}
