import 'dart:ui';
import 'package:blogapp/Pages/doctor_detail.dart';
import 'package:blogapp/Pages/sitterlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'doclist .dart';

class Baby_sitter extends StatefulWidget {
  const Baby_sitter({Key key}) : super(key: key);

  @override
  _Baby_sitterState createState() => _Baby_sitterState();
}

class _Baby_sitterState extends State<Baby_sitter> {
  var listsearch = [];
  Future getdata() async {
    var uri = Uri.parse("http://172.20.10.4/Hi_Baby/baby_sitter.php");
    var response = await http.get(uri);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future searchdata() async {
    var uri = Uri.parse("http://172.20.10.4/Hi_Baby/search_sitter.php");
    var response = await http.get(uri);
    var responsebody = jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      listsearch.add(responsebody[i]['name']);
    }
    print(listsearch);
  }

  @override
  void initState() {
    searchdata();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink.withOpacity(0.3),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: Datasearch(list: listsearch));
                    },
                    icon: Icon(Icons.search))
              ],
              title: Text("Baby Sitters",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return sitterlist(
                        name: snapshot.data[i]['name'],
                        detail: snapshot.data[i]['detail'],
                        location: snapshot.data[i]['location'],
                        phone_num: snapshot.data[i]['phone_num'],
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )));
  }
}

class Datasearch extends SearchDelegate<String> {
  List<dynamic> list;
  Datasearch({this.list});
  Future getsAdv() async {
    var uri = Uri.parse("http://172.20.10.4/Hi_Baby/searchsitter_adv.php");
    var data = {"searchsitter": query};
    var response = await http.post(uri, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
      future: getsAdv(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return sitterlist(
                name: snapshot.data[i]['name'],
                detail: snapshot.data[i]['detail'],
                location: snapshot.data[i]['location'],
                phone_num: snapshot.data[i]['phone_num'],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchlist =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(searchlist[i]),
            onTap: () {
              query = searchlist[i];
              showResults(context);
            },
          );
        });
  }
}
