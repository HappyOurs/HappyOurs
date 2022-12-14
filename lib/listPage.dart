import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:happyours/widgets/bar_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget {
  String location;

  List<DocumentSnapshot> documentList;

  ListPage({super.key, required this.location, required this.documentList});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
          children: [
            Text(
              widget.location,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  fontSize: width * 0.035),
            ),
            const Text(
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // searchbar
            Container(
              margin: EdgeInsets.only(top: width * 0.05, bottom: width * 0.1),
              height: width * 0.103,
              width: width * 0.886,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffc4c4c4),
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
            // Create a list view from firebase
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot bar = widget.documentList.elementAt(index);
                final data = bar.data()! as Map<String, dynamic>;
                return barCard(
                    img: "assets/card1.png",
                    name: data["name"],
                    type: "",
                    time: "4-7",
                    price: "\$ ",
                    rating: data["rating"],
                    dollar: data["PriceRange"],
                    up: false,
                    width: width);
                /*
                return ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    leading: const Icon(Icons.group),
                    title: Text(document.data()["name"]),
                    subtitle: Text(""),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(groupId: document.data()["id"]),
                        ),
                      );
                    });
                */
              },
              itemCount: widget.documentList.length,
            ),
/*
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
                */
          ],
        ),
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.

}
