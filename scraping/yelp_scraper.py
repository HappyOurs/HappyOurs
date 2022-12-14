import time

import logging
import csv
import requests
from geopy.geocoders import Nominatim

from scrapy.http import HtmlResponse

logging.basicConfig(level=logging.INFO)

INPUT_FILE_NAME = 'bars3_2.csv'
OUTPUT_FILE_NAME = 'bars3_2_output.csv'

def scrapeWordCount(wordFind, bar_id):
    url = "https://www.yelp.com/biz/{}?q={}".format(bar_id, wordFind)
    s = requests.Session()
    response = s.get(url).text.encode('utf-8')
    response = HtmlResponse(url=url, body=response)
    searchterm_reviews = response.xpath("//div[@class=' arrange-unit__09f24__rqHTg border-color--default__09f24__NPAKY nowrap__09f24__lBkC2']//span[@class=' css-qgunke']/text()").extract()
    result = searchterm_reviews[0].split(" ")[0]
    return result

def scrapeTotalPicturesAddress(bar_id):
    url = "https://www.yelp.com/biz/{}".format(bar_id)
    s = requests.Session()
    response = s.get(url).text.encode('utf-8')
    response = HtmlResponse(url=url, body=response)

    total_reviews = response.xpath("//p[@class=' css-foyide']/text()").extract()
    reviewsResult = total_reviews[0].split(" ")[0]

    picturesLinks = response.xpath("//img[@class=' photo-header-media-image__09f24__A1WR_']/@src").extract()

    address = response.xpath("//span[@class=' raw__09f24__T4Ezm']/text()").extract()
    addressResult = address[0]

    return reviewsResult, picturesLinks, addressResult

def scoreCalc(wordCount, reviewCount):
    score = float(wordCount) / float(reviewCount)
    return score

logging.info("Starting script.")

with open(INPUT_FILE_NAME, mode = 'r') as input, open(OUTPUT_FILE_NAME, mode = 'w') as output:
    logging.info("Input & Output file opened.")
    fieldnames = ['restaurantID', 'name','location','reviewCount','rating','categories','address','Hours','GoodforKids','AcceptsCreditCards','Parking','Attire','GoodforGroups','PriceRange','TakesReservations','Delivery','Takeout','WaiterService','OutdoorSeating','WiFi','GoodFor','Alcohol','NoiseLevel','Ambience','HasTV','Caters','WheelchairAccessible','webSite','phoneNumber','filReviewCount','totalReviews','picturesLinksArray','collegeScore','dateScore','wineScore','beerScore','longitute','latitude','fullAddress']
    writer = csv.DictWriter(output, fieldnames=fieldnames, delimiter=';')
    writer.writeheader()
    logging.info("Headers written to output file.")

    csv_reader = csv.DictReader(input, delimiter=';')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            line_count += 1

        logging.info("Bar Name: {}".format(row["name"]))

        try:
            intermediate = scrapeTotalPicturesAddress(bar_id = row["restaurantID"])
            if(intermediate[2] == "Yelpers report this location has closed."):
                logging.info("Address Scraped: {}".format("CLOSED"))
                continue
            logging.info("Address Scraped: {}".format(intermediate[2]))

            totalReviewsPerBar = intermediate[0]
            logging.info("Total Reviews: {}".format(totalReviewsPerBar))

            picturesLinks = intermediate[1]
            logging.info("Pictures Links Array: {}".format(picturesLinks))
            
        except:
            logging.info("Address Scraped: {}".format("ERROR"))
            continue

        try:
            collegeScore = scoreCalc(scrapeWordCount(bar_id = row["restaurantID"], wordFind = "college"), totalReviewsPerBar)
            logging.info("College Score: {}".format(collegeScore))
        except:
            logging.info("College Score: {}".format("ERROR"))
            continue
        try:
            dateScore = scoreCalc(scrapeWordCount(bar_id = row["restaurantID"], wordFind = "date"), totalReviewsPerBar)
            logging.info("Date Score: {}".format(dateScore))
        except:
            logging.info("Date Score: {}".format("ERROR"))
            continue

        try:
            wineScore = scoreCalc(scrapeWordCount(bar_id = row["restaurantID"], wordFind = "wine"), totalReviewsPerBar)
            logging.info("Wine Score: {}".format(wineScore))
        except:
            logging.info("Wine Score: {}".format("ERROR"))
            continue
        
        try:
            beerScore = scoreCalc(scrapeWordCount(bar_id = row["restaurantID"], wordFind = "beer"), totalReviewsPerBar)
            logging.info("Beer Score: {}".format(beerScore))
        except:
            logging.info("Beer Score: {}".format("ERROR"))
            continue

        try:
            geolocator = Nominatim(user_agent="yelp_scraper")
            location = geolocator.geocode(row["name"]+ " NYC")
            longitude = location.longitude
            latitude = location.latitude
            fullAddress = location.address

            logging.info("Latitude: {}, Longitude: {}".format(latitude, longitude))
            logging.info("Full Address: {}".format(fullAddress))
        except:
            logging.info("Latitude: {}, Longitude: {}".format("ERROR", "ERROR"))
            logging.info("Full Address: {}".format("ERROR"))
            continue

        writer.writerow({'restaurantID': row["restaurantID"], 'name': row["name"],'location': row["location"] ,'reviewCount': row["reviewCount"], 'rating': row["rating"], 'categories': row["categories"], 'address': row["address"],'Hours':row["Hours"], 'GoodforKids': row["GoodforKids"], 'AcceptsCreditCards': row["AcceptsCreditCards"],'Parking': row["Parking"], 'Attire': row["Attire"], 'GoodforGroups': row["GoodforGroups"],'PriceRange': row["PriceRange"],'TakesReservations' : row["TakesReservations"], 'Delivery': row["Delivery"],'Takeout': row["Takeout"], 'WaiterService': row["WaiterService"], 'OutdoorSeating':row["OutdoorSeating"], 'WiFi': row["WiFi"], 'GoodFor': row["GoodFor"],'Alcohol': row["Alcohol"],'NoiseLevel': row["NoiseLevel"],'Ambience': row["Ambience"],'HasTV':row["HasTV"], 'Caters': row["Caters"],'WheelchairAccessible': row["WheelchairAccessible"],'webSite': row["webSite"], 'phoneNumber': row["phoneNumber"],'filReviewCount': row["filReviewCount"], 'totalReviews': totalReviewsPerBar, 'picturesLinksArray': picturesLinks, 'collegeScore': collegeScore, 'dateScore': dateScore, 'wineScore': wineScore, 'beerScore': beerScore, 'longitute': longitude,'latitude': latitude,'fullAddress':fullAddress})
        logging.info("Write for {} complete successfull!".format(row["name"]))
    
        line_count += 1
    logging.info("SUCCESS! Processed {} lines.".format(line_count))

input.close()
logging.info("Input file closed.")
output.close()
logging.info("Output file closed.")