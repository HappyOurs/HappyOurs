import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget barCard(
    {required String img,
    required String name,
    required String type,
    required String time,
    required String price,
    required String rating,
    required String dollar,
    required double width,
    required bool up}) {
  return Container(
    width: width * 0.92,
    // height: width * 0.8,
    margin: EdgeInsets.only(
        left: width * 0.039, right: width * 0.039, bottom: width * 0.048),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 2.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //img
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Image.asset(
            img,
            // width: 150,
            height: width * 0.5,
            width: width * 0.92,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //name + rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  //Rating ->
                  Container(
                    height: width * 0.039,
                    width: width * 0.106,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.green),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            rating,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            size: 10,
                            color: Colors.white,
                          ),
                        ]),
                  )
                ],
              ),
              //type + dollar
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    type,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 9,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Flexible(
                    flex: 19,
                    child: Container(),
                  ),
                  Text(
                    dollar,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(
                height: width * 0.02,
              ),
              //msg
              Row(
                children: [
                  Flexible(
                    flex: 16,
                    child: Container(),
                  ),
                  Text(
                    "Happy hours ${time} pm: ${price} for a pint of beer",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xfff60f0f),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Flexible(
                    flex: 57,
                    child: Container(),
                  ),
                  //change img
                  if (up) Image.asset("assets/Arrow.png"),
                  Flexible(
                    flex: 73,
                    child: Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
