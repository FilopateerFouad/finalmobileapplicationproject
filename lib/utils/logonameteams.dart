import 'package:finalproject/widgets/customtext';
import 'package:flutter/material.dart';

logoNameTeams({required String logo, required String name}) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.network(
          logo,
          height: 35,
          width: 30,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      const SizedBox(width: 30),
      CustomText(
        text: name,
        isBold: true,
        colours: 0xFFFFFFFF,
        fontSize: 15,
      )
    ],
  );
}
