import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:post_api_integration/Models/photos.dart';
import 'package:http/http.dart' as http;
class SeconPage extends StatefulWidget {
  const SeconPage({Key? key}) : super(key: key);

  @override
  State<SeconPage> createState() => _SeconPageState();
}

class _SeconPageState extends State<SeconPage> {
  List<Photos> fetchData = [];

  Future<List<Photos>> getdata() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map i in data) {
        fetchData.add(Photos.fromJson(i));
      }
      return fetchData;
    } else {
      return fetchData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Post Api",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('laoding'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            fetchData[index].thumbnailUrl.toString()
                          ),
                        ),
                        title: Text('${fetchData[index].title.toString()}'),
                      );
                    },
                    itemCount: fetchData.length,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
