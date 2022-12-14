import csv
import firebase_admin
import google.cloud
from google.cloud.firestore import GeoPoint
import pygeohash as pgh

from firebase_admin import credentials, firestore

cred = credentials.Certificate("./ServiceAccountKey.json")
app = firebase_admin.initialize_app(cred)

store = firestore.client()

file_path = "./bars_master.csv"
collection_name = "bars_master"


def batch_data(iterable, n=1):
    l = len(iterable)
    for ndx in range(0, l, n):
        yield iterable[ndx:min(ndx + n, l)]


data = []
headers = []
with open(file_path) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=';')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            for header in row:
                headers.append(header)
            line_count += 1
        else:
            obj = {}
            arrayOfArrays = []
            longitudeLocal = 0
            latitudeLocal = 0
            stringBuilding = "["

            for idx, item in enumerate(row):
                if (headers[idx] == "picturesLinksArray"): 
                    arraystr =  eval(item.replace("\"[","[").replace("]\"","]"))
                    obj["pictureArray"] = arraystr
                    print("headers[idx] "+headers[idx])
                    print("item "+ str(arraystr))

                if (headers[idx] == "longitute"):
                    longitudeLocal = float(item)
                    continue
                if (headers[idx] == "latitude"):
                    latitudeLocal = float(item)
                    if (latitudeLocal != 0.0 and longitudeLocal != 0.0):
                        location = {"geohash" : pgh.encode(latitudeLocal, longitudeLocal), "geopoint" : GeoPoint(latitudeLocal, longitudeLocal)}                   
                        obj["location"] = location
                        print("headers[idx] "+headers[idx])
                        print("item "+ str(location))
                else:
                    obj[headers[idx]] = item
                    print("headers[idx] "+headers[idx])
                    print("item "+item)
            data.append(obj)
            print(obj)
            line_count += 1
    print(f'Processed {line_count} lines.')

for batched_data in batch_data(data, 499):
    batch = store.batch()
    for data_item in batched_data:
        doc_ref = store.collection(collection_name).document()
        batch.set(doc_ref, data_item)
    batch.commit()

print('Done')