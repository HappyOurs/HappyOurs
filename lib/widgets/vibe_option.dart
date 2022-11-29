import 'package:flutter/material.dart';

Widget vibeOption(
    {required String img, required String vibeName, required double width}) {
  return Container(
      height: width * 0.32,
      width: width * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.1),
            child: Image.asset(
              img,
              // width: 150,
              height: width * 0.2,
              width: width * 0.2,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Text(
              vibeName,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  fontSize: 12),
            ),
          ),
        ],
      ));
}
