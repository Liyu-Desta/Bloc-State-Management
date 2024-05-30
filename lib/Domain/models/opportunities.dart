import 'dart:convert';

class Opportunity {
  final String id; // Adding id field
  final String title;
  final String description;
  final String location;
  final DateTime date1;
  final DateTime? date2;
  final List<int>? image;

  Opportunity({
    required this.id, // Initializing id in the constructor
    required this.title,
    required this.description,
    required this.location,
    required this.date1,
    this.date2,
    this.image,
  });

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['_id'], // Make sure to adjust according to your API response
      title: json['title'],
      description: json['description'],
      location: json['location'],
      date1: DateTime.parse(json['date']),
      date2: json['date2'] != null ? DateTime.parse(json['date2']) : null,
      image: json['photo'] != null ? base64Decode(json['photo']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'date': date1.toIso8601String(),
      'date2': date2?.toIso8601String(),
      'photo': image != null ? base64Encode(image!) : null,
    };
  }
}
