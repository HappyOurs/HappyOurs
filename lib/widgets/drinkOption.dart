import 'package:flutter/material.dart';

class drinkOption extends StatelessWidget {
  const drinkOption({
    Key? key,
    required this.width,
    required this.text,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final double width;
  final String text;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: width * 0.041, bottom: width * 0.06),
        height: width * 0.070,
        width: width * 0.183,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isSelected ? Colors.deepOrangeAccent : const Color(0xffc4c4c4),
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
