import 'dart:convert';
import 'dart:math';
import 'package:examapp/models/scoreboard_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(context),
      body: _body(_width, _height),
    );
  }

  _appBar(context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'ScoreBoard',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }

  _body(width, height) {
    return Center(
      child: FutureBuilder(
        future: _getData(),
        builder: (context, AsyncSnapshot<List<ScoreBoardModel>> snap) {
          var data = snap.data!;
          if (snap.connectionState==ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: _listTile(data, index),
              ),
              itemCount: data.length,
            );
          }
        },
      ),
    );
  }

  ListTile _listTile(List<ScoreBoardModel> data, int index) {
    return ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text("${data[index].name}"),
                trailing: Text(
                  "${(399 - index*3.7*12).floor()}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://source.unsplash.com/random/$index"),
                ),
                subtitle: Text("${data[index].username}"),
                selected: true,
                selectedTileColor: Color.fromRGBO(Random().nextInt(254),
                    Random().nextInt(254), Random().nextInt(254), 1.0),
              );
  }

  Future<List<ScoreBoardModel>> _getData() async {
    var res =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    return (jsonDecode(res.body) as List)
        .map((e) => ScoreBoardModel.fromJson(e))
        .toList();
  }
}
