import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatsList extends StatefulWidget {
  const CatsList({super.key});

  @override
  State<CatsList> createState() => _CatsListState();
}

class _CatsListState extends State<CatsList> {
  Future<List>? _catsList;
  Future<List?> _getCats() async {
    final response =
        await http.get(Uri(host: "https://api.thecatapi.com/v1/breeds"));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      return throw Exception("Falló la conexión.");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCats();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
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
