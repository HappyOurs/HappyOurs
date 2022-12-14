import 'package:flutter/material.dart';

Widget vibeOption(
    {required String img,
    required String vibeName,
    required double width,
    bool isSelected = false,
    Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: width * 0.32,
        width: width * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              //Change colour to orange if isSelected is true

              borderRadius: BorderRadius.circular(width * 0.1),
              child: CircleAvatar(
                radius: width * 0.1,
                backgroundColor: Colors.deepOrange,
                child: CircleAvatar(
                  backgroundImage: AssetImage(img),
                  radius: isSelected ? width * 0.09 : width * 0.1,
                ),
              ),
            ),
            Expanded(
              child: Text(
                vibeName,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    fontSize: 14),
              ),
            ),
          ],
        )),
  );
}
