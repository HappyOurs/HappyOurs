import 'package:address_search_field/address_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:happyours/widgets/bar_card.dart';
import 'package:happyours/widgets/drinkOption.dart';
import 'package:happyours/widgets/vibe_option.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:overlay_support/overlay_support.dart';
import 'listPage.dart';

final geo = Geoflutterfire();
final _firestore = FirebaseFirestore.instance;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController locationController =
      TextEditingController(text: "Loading");

  String _currentAddress = "loading...";

  double? userLat;
  double? userLong;
  bool collegeSelected = false;
  bool dateSelected = false;
  bool beerSelected = false;
  bool wineSelected = false;

  void locationControllerText(String value) {
    setState(() {
      locationController.text = value;
    });
  }

  _goToListPage(List<DocumentSnapshot> barsInRange, List<double> scores) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListPage(
                location: locationController.text,
                documentList: barsInRange,
                scores: scores,
              )),
    );
  }

  @override
  void initState() {
    super.initState();
    _determinePosition()
        .then((value) => _getAddressFromLatLng(value.latitude, value.longitude))
        .catchError((e) {
      print(e);
    });
  }

  final geoMethods = GeoMethods(
    googleApiKey: 'AIzaSyAFPcrEMUGnDsKuEalgzN1n5zO1758ubW8',
    language: 'en',
    countryCode: 'us',
    countryCodes: ['us'],
    country: 'United States',
    city: 'New York',
  );

  Address? address;

  @override
  Widget build(BuildContext context) {
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
        title: Container(
          margin: EdgeInsets.only(left: width * 0.07, right: width * 0.07),
          child: TextField(
            decoration: const InputDecoration(
                hintStyle: TextStyle(
                    color: Color.fromRGBO(78, 89, 111, 1),
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope',
                    fontSize: 16),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(99, 196, 51, 1))),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromRGBO(78, 89, 111, 0.2),
                  ),
                ),
                focusColor: Color.fromRGBO(99, 196, 51, 1)),
            enabled: true,
            controller: locationController,
            autofocus: false,
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => AddressSearchDialog(
                      geoMethods: geoMethods,
                      controller: locationController,
                      onDone: (Address tempAddress) {
                        print(tempAddress.coords);
                        if (tempAddress.hasCoords) {
                          _getAddressFromLatLng(tempAddress.coords!.latitude,
                              tempAddress.coords!.longitude);
                        }
                      },
                    )),
            style: const TextStyle(
                color: Color.fromRGBO(78, 89, 111, 1),
                fontWeight: FontWeight.w800,
                fontFamily: 'Manrope',
                fontSize: 18.5),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _determinePosition()
                  .then((value) =>
                      _getAddressFromLatLng(value.latitude, value.longitude))
                  .catchError((e) {
                print(e);
              });
            },
            icon: const Icon(
              Icons.location_searching_sharp,
              color: Colors.black,
            ),
          )
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

                      vibeOption(
                        img: "assets/vibe1.png",
                        vibeName: "College",
                        width: width,
                        onTap: () {
                          setState(() {
                            collegeSelected = !collegeSelected;
                          });
                        },
                        isSelected: collegeSelected,
                      ),
                      vibeOption(
                        img: "assets/vibe2.png",
                        vibeName: "Romantic",
                        width: width,
                        onTap: () {
                          setState(() {
                            dateSelected = !dateSelected;
                          });
                        },
                        isSelected: dateSelected,
                      ),
                      vibeOption(
                        img: "assets/vibe3.png",
                        vibeName: "Dance Floor",
                        width: width,
                      ),
                      vibeOption(
                          img: "assets/vibe4.png",
                          vibeName: "Affordable",
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
                drinkOption(
                    width: width,
                    text: "Beer",
                    onTap: () {
                      setState(() {
                        beerSelected = !beerSelected;
                      });
                    },
                    isSelected: beerSelected),
                drinkOption(
                  width: width,
                  text: "Wine",
                  onTap: () {
                    setState(() {
                      wineSelected = !wineSelected;
                    });
                  },
                  isSelected: wineSelected,
                ),
                drinkOption(width: width, text: "Cocktails"),
                drinkOption(width: width, text: "Others"),
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

            //Create centered button
            GestureDetector(
              onTap: _search,
              child: Container(
                margin: EdgeInsets.only(top: width * 0.1),
                child: Center(
                  child: Container(
                    height: width * 0.15,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xfff60f0f),
                    ),
                    child: const Center(
                      child: Text(
                        "Search",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = p[0];
      if (mounted) {
        setState(() {
          _currentAddress =
              "${place.name},${place.subLocality}, ${place.locality}";
          print("Address : $_currentAddress");
          locationController.text = _currentAddress.toString();
        });
        userLat = latitude;
        userLong = longitude;
      }
      // Create a geoFirePoint

    } catch (e) {
      print(e);
    }
  }

  _search() async {
    if (userLat == null || userLong == null) {
      showSimpleNotification(const Text("Please select location"),
          background: Colors.red);
    } else if (beerSelected == false &&
        wineSelected == false &&
        collegeSelected == false &&
        dateSelected == false) {
      showSimpleNotification(
          const Text(
              "Please select drink type (Beer/Wine) or a vibe (College/Date) you're looking for"),
          background: Colors.red);
    } else {
      GeoFirePoint center = geo.point(latitude: userLat!, longitude: userLong!);

// get the collection reference or query
      var collectionReference = _firestore.collection('bars_master');

      double radius = 0.5;
      String field = 'location';

      List<DocumentSnapshot<Object?>> barsInRange = await ((geo
              .collection(collectionRef: collectionReference)
              .within(center: center, radius: radius, field: field))
          .first);

      barsInRange.sort((a, b) {
        var aData = (a.data()! as Map<String, dynamic>);
        var bData = (b.data()! as Map<String, dynamic>);
        double aScoreCount = 0;
        double bScoreCount = 0;
        if (beerSelected) {
          aScoreCount += double.parse(aData['beerScore']);
          bScoreCount += double.parse(bData['beerScore']);
        }
        if (wineSelected) {
          aScoreCount += double.parse(aData['wineScore']);
          bScoreCount += double.parse(bData['wineScore']);
        }
        if (collegeSelected) {
          aScoreCount += double.parse(aData['collegeScore']);
          bScoreCount += double.parse(bData['collegeScore']);
        }
        if (dateSelected) {
          aScoreCount += double.parse(aData['dateScore']);
          bScoreCount += double.parse(bData['dateScore']);
        }
        return bScoreCount.compareTo(aScoreCount);
      });
      List<double> scores = [];
      for (DocumentSnapshot doc in barsInRange) {
        print(doc.data());

        var data = (doc.data()! as Map<String, dynamic>);
        double scoreCount = 0;
        if (beerSelected) {
          scoreCount += double.parse(data['beerScore']);
        }
        if (wineSelected) {
          scoreCount += double.parse(data['wineScore']);
        }
        if (collegeSelected) {
          scoreCount += double.parse(data['collegeScore']);
        }
        if (dateSelected) {
          scoreCount += double.parse(data['dateScore']);
        }
        scores.add(scoreCount);
        print(scoreCount);
      }

      _goToListPage(barsInRange, scores);
    }
  }
}
