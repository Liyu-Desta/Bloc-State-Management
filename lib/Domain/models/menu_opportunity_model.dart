import 'dart:convert';
import 'dart:typed_data';

class MenuOpportunity {
  final String id;
  
  final String title;
  final String description;
  final String location;
  final DateTime? date1;
  final DateTime? date2;
  final Uint8List? image;

  MenuOpportunity({
    required this.id,
    
    required this.title,
    required this.description,
    required this.location,
    required this.date1,
    required this.date2,
    required this.image,
  });

  factory MenuOpportunity.fromJson(Map<String, dynamic> json) {
    return MenuOpportunity(
      id: json['_id'],
       // This might be null
      title: json['title'],
      description: json['description'],
      location: json['location'],
      date1: json['date'] != null ? DateTime.parse(json['date']) : null,
      date2: json['date2'] != null ? DateTime.parse(json['date2']) : null,
      image: json['photo'] != null ? base64Decode(json['photo']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      
      'title': title,
      'description': description,
      'location': location,
      'date1': date1,
      'date2': date2,
      'photo': image != null ? base64Encode(image!) : null,
    };
  }
}
