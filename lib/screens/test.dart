import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrekkingTrailsPage extends StatefulWidget {
  const TrekkingTrailsPage({Key? key}) : super(key: key);

  @override
  _TrekkingTrailsPageState createState() => _TrekkingTrailsPageState();
}

class _TrekkingTrailsPageState extends State<TrekkingTrailsPage> {
  late Future<List<TrekkingTrail>> _trailsFuture;

  @override
  void initState() {
    super.initState();
    _trailsFuture = _fetchTrails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trekking Trails'),
      ),
      body: Center(
        child: FutureBuilder<List<TrekkingTrail>>(
          future: _trailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final trails = snapshot.data!;
              return ListView.builder(
                itemCount: trails.length,
                itemBuilder: (context, index) {
                  final trail = trails[index];
                  return ListTile(
                    leading: Image.network(trail.imageUrl),
                    title: Text(trail.title),
                    subtitle: Text(trail.location),
                  );
                },
              );
            } else {
              return Text('No data available.');
            }
          },
        ),
      ),
    );
  }

  Future<List<TrekkingTrail>> _fetchTrails() async {
    final response = await http
        .get(Uri.parse('https://your-django-backend-url.com/api/trails/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final trails =
          data.map((trailData) => TrekkingTrail.fromJson(trailData)).toList();
      return trails;
    } else {
      throw Exception('Failed to fetch trails');
    }
  }
}

class TrekkingTrail {
  final String imageUrl;
  final String title;
  final String location;

  TrekkingTrail({
    required this.imageUrl,
    required this.title,
    required this.location,
  });

  factory TrekkingTrail.fromJson(Map<String, dynamic> json) {
    return TrekkingTrail(
      imageUrl: json['image_url'],
      title: json['title'],
      location: json['location'],
    );
  }
}
