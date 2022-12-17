# HappyOurs

HappyOurs is a Flutter project that allows users to discover and rate happy hour specials at local bars. It includes features such as searching for bars by location, price range, and type of drink, as well as saving favorite bars and viewing live mood ratings.

### Dependencies
The following dependencies are required for this Flutter project:

```flutter
cupertino_icons
firebase_core
cloud_firestore
firebase_auth
google_sign_in
overlay_support
pin_code_fields
geoflutterfire
geolocator
geocoding
address_search_field
flutter_riverpod
carousel_slider
speech_to_text
url_launcher
```

### Setup
To run this Flutter project, follow these steps:

Make sure that you have Flutter installed on your machine. You can install Flutter by following the instructions at https://flutter.dev/docs/get-started/install.

Clone or download this repository.

Navigate to the root directory of the repository and run flutter pub get to install the required dependencies.

Connect an Android or iOS device to your machine, or start an emulator.

Run flutter run to build and run the app on your device or emulator.

### Assets
This Flutter project includes assets such as images and fonts located in the assets directory. You can add or modify these assets to customize the app's appearance.

### Flutter Launcher Icons
This Flutter project uses the flutter_launcher_icons package to generate app icons for Android and iOS. The app icon is specified in the pubspec.yaml file in the flutter_icons section. You can modify this section to use a different app icon.

## Home Page

It uses the address_search_field and cloud_firestore packages to allow the user to search for bars by location and various preferences. The geolocator and geocoding packages are used to determine the user's current location, and the geoflutterfire package is used to query a Firestore database for bars within a certain distance of the user's location. The overlay_support and speech_to_text packages are used to allow the user to input their search queries by speaking.

### Classes and Variables
The HomePage class extends StatefulWidget and has a state class called _HomePageState, which handles the logic for the bar search feature. The _HomePageState class has several instance variables, including:

- searchController: a TextEditingController used to handle user input
- locationController: a TextEditingController used to display the user's current location
- _speechToText: an object of the SpeechToText class used for speech recognition
- _speechEnabled: a boolean variable that is true if speech recognition is available on the device

It also has several boolean variables that track whether certain preferences have been selected by the user:

- collegeSelected

- dateSelected

- beerSelected

- wineSelected

### Methods
The _HomePageState class has several methods that are called at various points in the app's lifecycle:

- _initSpeech: initializes the _speechToText object and sets the _speechEnabled variable to true if speech recognition is available on the device
- _startListening: allows the user to start a speech recognition session
- _stopListening: allows the user to stop a speech recognition session
- _onSpeechResult: called when the platform returns recognized words
- locationControllerText: updates the text displayed in the locationController text field
- _goToListPage: navigates to a new screen that displays a list of bars that match the user's search criteria
- The initState method initializes the _speechToText object and determines the user's current location by calling the _determinePosition and _getAddressFromLatLng methods. The _determinePosition method uses the geolocator package to determine the user's current latitude and longitude, and the _getAddressFromLatLng method uses the geocoding package to reverse geocode the latitude and longitude and determine the user's current address. The searchController.addListener method adds a listener to the searchController text field that updates the boolean variables based on the contents of the search query.

## List Page

This displays a list of data of bars from Cloud Firestore database and allows the user to search for specific items in the list.

The ListPage widget takes several arguments in its constructor:

- location: a string representing the location of the items in the list
- documentList: a list of DocumentSnapshot objects, which contain data from the Cloud Firestore database
- scores: a list of doubles representing scores associated with each item in the documentList
- geoPoint: a GeoFirePoint object representing the geographical location of the items in the list

The ListPage widget has a stateful inner class called _ListPageState which handles the search functionality. When the user types in the search bar, the filterSearchResults method is called, which filters the list of items and their corresponding scores based on the query entered by the user. The filtered list is then displayed in the Scaffold body.

## Other pages

- `main.dart`: The entry point of the app. It uses the MaterialApp widget to display the app's home page.
- `Login.dart` : This page allows the user to login using their Google account / Phone number
- `Auth.dart` : This file contains the Auth class, which handles the authentication logic for the app. It uses the firebase_auth and google_sign_in packages to authenticate the user.
- `emailLogin.dart` : This file contains the EmailLogin class, which handles the logic for the email login feature. It uses the firebase_auth package to authenticate the user.
- `OTP.dart` : This file contains the OTP class, which handles the logic for the OTP verification feature. It uses the firebase_auth package to authenticate the user.
- `bar_card.dart` : This file contains the BarCard class, which displays a card for each bar in the list of bars.
- `drinkOption.dart` : This file contains the DrinkOption class, which displays a card for each drink option in the list of drink options.
- `vibe_option.dart` : This file contains the VibeOption class, which displays a card for each vibe option in the list of vibe options.


## [CSV to Firestore Import Tool](https://github.com/HappyOurs/HappyOurs/blob/main/scraping/main.py)
This code is a tool for importing data from a CSV file into a Firestore database. The code reads in a CSV file, parses the data, and then batches and inserts the data into a Firestore collection.

### Dependencies
The following dependencies are required for this code:

```
csv
firebase_admin
google.cloud
pygeohash
```

### Setup
To use this code, follow these steps:

Make sure that you have the necessary dependencies installed. You can install them using pip:

```pip install csv firebase_admin google.cloud pygeohash```

Place your CSV file in the same directory as the code and update the file_path variable to the filename of your CSV file.

Update the collection_name variable to the name of the Firestore collection that you want to import the data into.

Set up a Firebase project and download a Service Account Key JSON file. Place the JSON file in the same directory as the code and update the cred variable to the path of the JSON file.

Run the code using Python. The data from the CSV file will be imported into the specified Firestore collection.

### Code Description

We used a Python script that is used to scrape data from the Yelp website for a set of restaurants. The script is designed to take a list of restaurant IDs and extract various information about each restaurant, including its name, location, review count, rating, categories, address, hours, amenities, and contact information.

The script uses several libraries such as requests, csv, and geopy to facilitate the data scraping process. It uses the requests library to make HTTP requests to the Yelp website and retrieve the HTML content of each restaurant's page. It then uses the csv library to read an input file containing a list of restaurant IDs, and the geopy library to retrieve the latitude and longitude coordinates of each restaurant's address.

The script also uses the HtmlResponse class from the scrapy library to parse the HTML content of each restaurant's page and extract the desired data using XPath expressions. It then writes the extracted data to an output file in CSV format, using the csv library.

The script also includes several functions for specific tasks, such as scrapeWordCount, which is used to count the number of occurrences of a specific keyword in the reviews of a restaurant, and scoreCalc, which is used to calculate a score for each restaurant based on the number of occurrences of certain keywords in its reviews.

The script is designed to handle errors that may occur during the data scraping process, such as captchas, and to log information about each restaurant's data scraping process to help with debugging and troubleshooting.

## [Yelp Scraper](https://github.com/HappyOurs/HappyOurs/blob/main/scraping/yelp_scraper.py)
This code is a tool for scraping data from Yelp.com. The code reads in a CSV file containing restaurant IDs and scrapes information about each restaurant, including its name, location, number of reviews, rating, categories, address, hours, amenities, price range, and website. The code also scrapes the number of reviews containing certain keywords (e.g. "college", "date", "wine", "beer") and calculates a score for each keyword based on the number of reviews containing the keyword relative to the total number of reviews for the restaurant. The scraped data is then written to a new CSV file.

### Dependencies
The following dependencies are required for this code:

time
logging
csv
requests
geopy 

### Setup
To use this code, follow these steps:

Make sure that you have the necessary dependencies installed. You can install them using pip:

```pip install time logging csv requests geopy```

Place your input CSV file in the same directory as the code and update the INPUT_FILE_NAME variable to the filename of your input CSV file.

Update the OUTPUT_FILE_NAME variable to the desired filename for the output CSV file.

Run the code using Python. The scraped data will be written to the output CSV file.

### Code Description

This is a script that is used to upload the data collected and processed in the previous steps to the Firebase Firestore database. The script reads the data from a CSV file and then uses the firebase_admin and google.cloud libraries to interact with the Firestore database.

The script uses the GeoPoint class from the google.cloud.firestore library to convert the location data from the CSV file into a GeoPoint object, which is a data type that represents a geographic location in the Firestore database. This allows the data to be queried and sorted based on location in the app.

The script also stores the images as an array of strings containing links to the images. This allows the images to be easily accessed and displayed in the app.

The script uses the batch_data function to break the data into smaller batches and then uses the batch.set method to write the data to the Firestore database in a transactional manner. This ensures that the data is written to the database in a consistent and reliable way, even if there are errors or interruptions during the process.

Overall, this script is an important part of the process of developing the HappyOurs app, as it allows the data collected and processed in the previous steps to be stored in a secure and easily accessible way.

