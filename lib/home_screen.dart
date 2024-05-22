import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_api_assignment/model.dart';
import 'package:get_api_assignment/photo_detail_screen.dart';
import 'package:http/http.dart ' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotoList> photolist = [];

  Future<List<PhotoList>> getDataFromApi() async {
    String getphotosUrl = 'https://jsonplaceholder.typicode.com/photos';
    var response = await http.get(Uri.parse(getphotosUrl));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('got 200');

      for (Map<String, dynamic> index in data) {
        photolist.add(PhotoList.fromJson(index));
      }
      return photolist;
    } else {
      print('failed');
      return photolist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Photo Gellery'),
      ),
      body: FutureBuilder(
        future: getDataFromApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Text(
              'loading..',
              style: TextStyle(fontSize: 40),
            ));
          } else {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) { return
                        PhotoDetailScreen(
                            imgUrl: photolist[index].url.toString(),
                            title: photolist[index].title.toString(),
                            id: photolist[index].id.toString());
                      },
                    ));
                  },
                  leading: CachedNetworkImage(
                    imageUrl: photolist[index].thumbnailUrl.toString(),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(photolist[index].title.toString()),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }
        },
      ),
    );
  }
}
