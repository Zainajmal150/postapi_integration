import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:post_api_integration/Models/usermodel.dart';
import 'package:http/http.dart' as http;
class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List<UserModel> fetchData = [];

  Future<List<UserModel>> getdata() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map i in data) {
        fetchData.add(UserModel.fromJson(i));
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
                          child: Center(
                            child: Text('${fetchData[index].id}'),
                          ),
                        ),
                        title: Text('${fetchData[index].email.toString()}'),
                        subtitle: Text('${fetchData[index].address!.city.toString()}'),
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
