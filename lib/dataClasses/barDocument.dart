// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class barDoc {
  final String id;
  final String barId;
  final String name;
  final String address;
  final String phone;
  final String price;
  final double rating;
  final int reviewCount;
  final String website;
  barDoc({
    required this.id,
    required this.barId,
    required this.name,
    required this.address,
    required this.phone,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.website,
  });

  barDoc copyWith({
    String? id,
    String? barId,
    String? name,
    String? address,
    String? phone,
    String? price,
    double? rating,
    int? reviewCount,
    String? website,
  }) {
    return barDoc(
      id: id ?? this.id,
      barId: barId ?? this.barId,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      website: website ?? this.website,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'barId': barId,
      'name': name,
      'address': address,
      'phone': phone,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'website': website,
    };
  }

  String toJson() => json.encode(toMap());

  //Generate firebase document
  factory barDoc.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> document}) {
    return barDoc(
      id: document.id,
      barId: document.data()!['restaurantID'] as String,
      name: document.data()!['name'] as String,
      address: document.data()!['address'] as String,
      phone: document.data()!['phoneNumber'] as String,
      price: document.data()!['PriceRange'] as String,
      rating: document.data()!['rating'] as double,
      reviewCount: document.data()!['reviewCount'] as int,
      website: document.data()!['webSite'] as String,
    );
  }

  @override
  String toString() {
    return 'barDoc(id: $id, barId: $barId, name: $name, address: $address, phone: $phone, price: $price, rating: $rating, reviewCount: $reviewCount, website: $website)';
  }

  @override
  bool operator ==(covariant barDoc other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.barId == barId &&
        other.name == name &&
        other.address == address &&
        other.phone == phone &&
        other.price == price &&
        other.rating == rating &&
        other.reviewCount == reviewCount &&
        other.website == website;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        barId.hashCode ^
        name.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        reviewCount.hashCode ^
        website.hashCode;
  }
}
