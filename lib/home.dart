import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:happyours/widgets/bar_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          //needs change
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
          children: [
            // searchbar

            Container(
              margin: EdgeInsets.only(top: width * 0.05, bottom: width * 0.1),
              height: width * 0.103,
              width: width * 0.886,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffc4c4c4),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.only(left: width * 0.058),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Color(0xfff60f0f),
                  ),
                  hintText: "Search for Pubs, Bars and Clubs",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 17),
                ),
              ),
            ),
            // card1
            barCard(
                img: "assets/card1.png",
                name: "The Penrose",
                type: "Upscale drinks",
                time: "4-7",
                price: "\$7",
                rating: "4.3",
                dollar: "\$\$",
                up: false,
                width: width),
            //card2
            barCard(
                img: "assets/card2.png",
                name: "Doff",
                type: "Sports Bar",
                time: "12-3 ",
                price: "\$4",
                rating: "4.2",
                dollar: "\$\$\$",
                up: true,
                width: width),
          ],
        ),
      ),
      // SafeArea(
      //   child: Center(
      //     child: Container(
      //       child: const Text("Page under construction"),
      //     ),
      //   ),
      // ),
    );
  }
}
