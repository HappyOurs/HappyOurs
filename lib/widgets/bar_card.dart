import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BarCard extends StatelessWidget {
  BarCard({
    this.imgArray,
    this.name,
    this.type,
    this.price,
    this.rating,
    this.dollar,
    Key? key,
    this.time,
  }) : super(key: key);

  List? imgArray;
  String? name;
  double? type;
  String? time;
  String? price;
  String? rating;
  String? dollar;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.92,
      // height: width * 0.8,
      margin: EdgeInsets.only(
          left: width * 0.039, right: width * 0.039, bottom: width * 0.048),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
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
              child: CarouselSlider(
                options: CarouselOptions(),
                items: imgArray!
                    .map((item) => Container(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                      height: width * 0.5,
                                      width: width * 0.92,
                                    ),
                                  ],
                                )),
                          ),
                        ))
                    .toList(),
              )),
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
                      name!,
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
                              rating!,
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
                      "Distance : ${(type! * 1093.61).toStringAsPrecision(4)} yards",
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
                      dollar!,
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
                    Text(
                      "Hours : ${time}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color(0xfff60f0f),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                      ),
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
}
