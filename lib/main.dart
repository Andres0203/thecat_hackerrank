import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thecat_hackerrank/models/catclasses.dart';

void main() => runApp(const CatClass());

class CatClass extends StatefulWidget {
  const CatClass({super.key});

  @override
  State<CatClass> createState() => _CatClassState();
}

var url = Uri.https('api.thecatapi.com', '/v1/breeds', {'q': '{http}'});

class _CatClassState extends State<CatClass> {
  Future<List<CatsPost>>? _catsList;
  Future<List<CatsPost>> _getCats() async {
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
      return cats;
    } else {
      return throw Exception("Falló la conexión.");
    }
  }

  @override
  void initState() {
    super.initState();
    _catsList = _getCats();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: _catsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _catsList2(snapshot.data),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

List<Widget> _catsList2(List<CatsPost>? data) {
  List<Widget> cats = [];

  for (var cat in data!) {
    cats.add(Card(
      child: Column(children: [Image.network(CatsPost.imageUrl)]),
    ));
  }
  return _catsList2(data);
}

CatsPost catos = CatsPost();

class CatsPost {
  final String breedName;
  final String origin;
  final int affectionLevel;
  final int intelligence;
  final dynamic imageUrl;

  CatsPost(this.breedName, this.origin, this.affectionLevel, this.intelligence,
      this.imageUrl) {}
}
