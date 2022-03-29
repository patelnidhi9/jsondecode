import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jsondecode/telephone.dart';
void main()
{
  runApp(MaterialApp(home:jsondecoding() ,));
}
class jsondecoding extends StatefulWidget {
  const jsondecoding({Key? key}) : super(key: key);

  @override
  _jsondecodingState createState() => _jsondecodingState();
}

class _jsondecodingState extends State<jsondecoding> {
  getAllData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List list = jsonDecode(response.body);

    // List<Auto> autolist = [];
    //
    // for(int i=0;i<list.length;i++)
    //   {
    //     Auto auto = Auto.fromJson(list[i]);
    //     autolist.add(auto);
    //   }

    List<Auto> autolist = list.map((e) => Auto.fromJson(e)).toList();

    return autolist;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map<String, dynamic> m = {
      "id": 1,
      "name": "Leanne Graham",
      "username": "Bret",
      "email": "Sincere@april.biz",
      "address": {
        "street": "Kulas Light",
        "suite": "Apt. 556",
        "city": "Gwenborough",
        "zipcode": "92998-3874",
        "geo": {
          "lat": "-37.3159",
          "lng": "81.1496"
        }
      },
      "phone": "1-770-736-8031 x56442",
      "website": "hildegard.org",
      "company": {
        "name": "Romaguera-Crona",
        "catchPhrase": "Multi-layered client-server neural-net",
        "bs": "harness real-time e-markets"
      }
    };
    Telephone tl = Telephone.fromJson(m);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Auto> list = snapshot.data as List<Auto>;

              return ListView.builder(itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(

                    leading: Text("${list[index].id}"),
                    title: Text("${list[index].title}"),
                    subtitle: Text("${list[index].body}"),
                  );
                },
              );
            }
            return Center(child: Text("No Data"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Auto {
  int? userId;
  int? id;
  String? title;
  String? body;

  Auto({this.userId, this.id, this.title, this.body});

  Auto.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
