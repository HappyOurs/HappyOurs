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
  List<double> scores;

  ListPage(
      {super.key,
      required this.location,
      required this.documentList,
      required this.scores});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> documentDuplicate = [];
  List<double> scoresDuplicate = [];

  void filterSearchResults(String query) {
    List<DocumentSnapshot> dummySearchList = <DocumentSnapshot>[];
    List<double> dummySearchListScores = <double>[];
    dummySearchList.addAll(documentDuplicate);
    dummySearchListScores.addAll(scoresDuplicate);
    if (query.isNotEmpty) {
      List<DocumentSnapshot> dummyListData = <DocumentSnapshot>[];
      List<double> dummyListDataScores = <double>[];
      for (DocumentSnapshot doc in dummySearchList) {
        if ((doc.data() as Map<String, dynamic>)["name"]
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummyListData.add(doc);
          dummyListDataScores
              .add(dummySearchListScores[dummySearchList.indexOf(doc)]);
        }
      }
      setState(() {
        documentDuplicate.clear();
        documentDuplicate.addAll(dummyListData);
        scoresDuplicate.clear();
        scoresDuplicate.addAll(dummyListDataScores);
      });
      return;
    } else {
      setState(() {
        documentDuplicate.clear();
        documentDuplicate.addAll(widget.documentList);
        scoresDuplicate.clear();
        scoresDuplicate.addAll(widget.scores);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    documentDuplicate.addAll(widget.documentList);
    scoresDuplicate.addAll(widget.scores);
  }

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
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
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
                DocumentSnapshot bar = documentDuplicate.elementAt(index);
                final data = bar.data()! as Map<String, dynamic>;
                return BarCard(
                  imgArray: data['pictureArray'],
                  name: data["name"],
                  type: "",
                  time: data["Hours"],
                  price: "\$ ",
                  rating: (widget.scores.elementAt(index) * 100)
                      .toStringAsPrecision(3),
                  dollar: data["PriceRange"],
                );
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
              itemCount: documentDuplicate.length,
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
