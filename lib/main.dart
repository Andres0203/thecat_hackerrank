import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

var url = Uri.https('api.thecatapi.com', '/v1/breeds', {'q': '{http}'});

class _MyAppState extends State<MyApp> {
  Future<List<CatsPost>>? _catsList;
  Future<List<CatsPost>?> _getCats() async {
    final response = await http.get(url);

    List<CatsPost> cats = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var i in jsonData) {
        cats.add(CatsPost(
            breedName: i["name"],
            origin: i["origin"],
            affectionLevel: i["affection_level"],
            intelligence: i["intelligence"],
            imageUrl: i["image"]));
      }
    } else {
      return throw Exception("Falló la conexión.");
    }
    print(cats);
  }

  @override
  void initState() {
    super.initState();
    _getCats();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

class CatsPost {
  final String? breedName;
  final String? origin;
  final int? affectionLevel;
  final int? intelligence;
  final dynamic imageUrl;

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
