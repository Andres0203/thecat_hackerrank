import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CatsProfile extends StatelessWidget {
  const CatsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

var urihttp = Uri.http('https://api.thecatapi.com/v1/breeds');

Future<http.Response> catspost() {
  return http.get(urihttp);
}

class CatsPost {
  final String? breedName;
  final String? origin;
  final int? affectionLevel;
  final int? intelligence;
  final String? imageUrl;

  CatsPost(
      {this.breedName,
      this.origin,
      this.affectionLevel,
      this.intelligence,
      this.imageUrl});

  factory CatsPost.fromJson(Map<String, dynamic> json) {
    return CatsPost(
      breedName: json['breedName'],
      origin: json['origin'],
      affectionLevel: json['affectionLevel'],
      intelligence: json['intelligence'],
      imageUrl: json['imageUrl'],
    );
  }
}
