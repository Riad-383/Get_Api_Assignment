import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String id;
  const PhotoDetailScreen({  super.key, required this.imgUrl, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Detail'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
                imgUrl),
            SizedBox(
              height: 10,
            ),
            Text('Title: $title'),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('ID: $id'))
          ],
        ),
      ),
    );
  }
}
