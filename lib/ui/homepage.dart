import 'dart:math';

import 'package:examapp/ui/fakescoreboard.dart';
import 'package:flutter/material.dart';
import 'package:examapp/alghoritms/algorithm.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? listLenght;

  final TextEditingController _controller = TextEditingController();
  var key = GlobalKey<FormFieldState>();
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
        'HomePage',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.stacked_bar_chart_outlined),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ScoreBoard()));
          },
        )
      ],
    );
  }

  _body(width, height) {
    return SingleChildScrollView(
      child: Form(
        key: key,
        child: Column(
          children: [
            _inputSection(),
            SingleChildScrollView(
              child: SizedBox(
                width: width,
                height: height * 0.8,
                child: _generator(width),
              ),
            )
          ],
        ),
      ),
    );
  }

  _generator(double width) {
    if (listLenght == null) {
      return null;
    } else {
      return listLenght! % 2 == 0 ? _listView(width) : _gridView(width);
    }
  }

  GridView _gridView(double width) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.75,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _container(width, index);
        },
        itemCount: listLenght);
  }

  ListView _listView(double width) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: _container(width, index),
        );
      },
      itemCount: listLenght,
    );
  }

  Container _container(double width, int index) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Color.fromRGBO(Random().nextInt(254), Random().nextInt(254),
            Random().nextInt(254), 1.0),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      width: width,
      child: Text(
        "${index + 1}",
        style: const TextStyle(color: Colors.white, fontSize: 35),
      ),
    );
  }

  Padding _inputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        validator: (v) {
          if (v!.isEmpty) {
            return "Son yoki sonlar to'plamini kiriting";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: IconButton(
            splashRadius: 14,
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              setState(() {});
              listLenght = (direction(_controller.text) * 0.12).floor();
              listLenght = listLenght == 0 ? 1 : listLenght;
            },
          ),
        ),
      ),
    );
  }
}
