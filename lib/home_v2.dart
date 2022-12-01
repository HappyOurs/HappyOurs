import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:happyours/widgets/bar_card.dart';
import 'package:happyours/widgets/vibe_option.dart';

import 'home.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int _price = 200;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          //needs change //
          Icons.location_pin,
          color: Colors.black,
        ),
        leadingWidth: width * 0.1,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "New York University",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  fontSize: 12),
            ),
            Text(
              "................................................................................",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  fontSize: 12),
            ),
          ],
        ),
        actions: [
          const Icon(
            //needs change
            Icons.menu,
            color: Colors.black,
          ),
          SizedBox(
            width: width * 0.05,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //searchbar
            Container(
              margin: EdgeInsets.only(
                  top: width * 0.05, left: width * 0.041, bottom: width * 0.06),
              height: width * 0.103,
              width: width * 0.92,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffc4c4c4),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.only(left: width * 0.018),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Color(0xfff60f0f),
                  ),
                  Container(
                    height: width * 0.103,
                    width: width * 0.71,
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "What are you looking for tonight?",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        child: const Icon(
                      Icons.mic,
                      color: Color(0xfff60f0f),
                    )),
                  ),
                ],
              ),
            ),
            //or
            Container(
              width: width * 0.92,
              margin: EdgeInsets.only(
                left: width * 0.041,
              ),
              // padding: EdgeInsets.only(left: width * 0.018),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        // height: 36,
                      ),
                    ),
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        fontSize: 15),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        // height: 36
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //set your vibe->
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.041,
                bottom: width * 0.043,
              ),
              child: const Text(
                "Set your vibe",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    fontSize: 20),
              ),
            ),
            // options->
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Go to HomePage on Tap

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                        child: vibeOption(
                            img: "assets/vibe1.png",
                            vibeName: "Affordable",
                            width: width),
                      ),
                      vibeOption(
                          img: "assets/vibe2.png",
                          vibeName: "Romantic",
                          width: width,
                      isSelected: true),
                      vibeOption(
                          img: "assets/vibe3.png",
                          vibeName: "Dance Floor",
                          width: width,
                          isSelected: false),
                      vibeOption(
                          img: "assets/vibe4.png",
                          vibeName: "College Crowd",
                          width: width),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      vibeOption(
                          img: "assets/vibe5.png",
                          vibeName: "Conversation Friendly",
                          width: width),
                      vibeOption(
                          img: "assets/vibe6.png",
                          vibeName: "Outdoor",
                          width: width),
                      vibeOption(
                          img: "assets/vibe7.png",
                          vibeName: "Pet - Friendly",
                          width: width),
                      vibeOption(
                          img: "assets/vibe8.png",
                          vibeName: "Premium",
                          width: width),
                    ],
                  ),
                ],
              ),
            ),
            //see more->
            GestureDetector(
              onTap: () {},
              child: Container(
                  margin: EdgeInsets.only(
                      left: width * 0.041, bottom: width * 0.06),
                  height: width * 0.063,
                  width: width * 0.92,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffc4c4c4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "See more",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            fontSize: 9),
                      ),
                      Icon(
                        Icons.expand_more_outlined,
                        size: 15,
                      )
                    ],
                  )),
            ),

            //Drink filter->
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.041,
                bottom: width * 0.043,
              ),
              child: const Text(
                "Drink type",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    fontSize: 20),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                        left: width * 0.041, bottom: width * 0.06),
                    height: width * 0.070,
                    width: width * 0.183,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffc4c4c4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Beer",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                        left: width * 0.041, bottom: width * 0.06),
                    height: width * 0.070,
                    width: width * 0.183,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffc4c4c4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Wine",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                        left: width * 0.041, bottom: width * 0.06),
                    height: width * 0.070,
                    width: width * 0.183,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffc4c4c4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Cocktail",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                        left: width * 0.041, bottom: width * 0.06),
                    height: width * 0.070,
                    width: width * 0.183,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffc4c4c4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Other",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //price range->
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.041,
                bottom: width * 0.03,
              ),
              child: const Text(
                "Price range",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    fontSize: 20),
              ),
            ),
            //slider->
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Color(0xfff60f0f),
                inactiveTrackColor: Colors.grey,
                trackShape: RectangularSliderTrackShape(),
                trackHeight: 4.0,
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
              ),
              child: Slider(
                value: _price.toDouble(),
                min: 1,
                max: 2000,
                label: "Select price range",
                onChanged: (value) {
                  setState(() {
                    _price = value.round();
                  });
                },
              ),
            ),
            // Slider(
            //     value: _price.toDouble(),
            //     min: 1.0,
            //     max: 20.0,
            //     activeColor: Color(0xfff60f0f),
            //     inactiveColor: Colors.grey,
            //     label: 'Select price range',
            //     onChanged: (double newValue) {
            //       setState(() {
            //         _price = newValue.round();
            //       });
            //     },
            //     semanticFormatterCallback: (double newValue) {
            //       return '${newValue.round()} dollars';
            //     })
          ],
        ),
      ),
    );
  }
}
