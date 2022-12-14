import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/postmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> fetchData = [];

  Future<List<PostModel>> getdata() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map i in data) {
        fetchData.add(PostModel.fromJson(i));
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
                        title: Text('Title:\n${fetchData[index].title.toString()}'),
                        subtitle: Text(fetchData[index].userId.toString()),
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
