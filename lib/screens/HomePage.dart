import 'dart:async';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapi/widget/showInfoWeather.dart';
import '../container.dart';
import '../parseJson.dart';

const String kTitleHomePage = 'Home';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SimpleAutoCompleteTextField textField;
  String currentText = "";
  String nameCity;
  double _lat;
  double _lon;

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  Future<void> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _lat = position.latitude;
    _lon = position.longitude;
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            kTitleHomePage,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: <Widget>[

            Padding(
              padding: EdgeInsets.all(50),
              child: SimpleAutoCompleteTextField(
                  controller: TextEditingController(text: cityList[0]),
                  suggestions: cityList,
                  textChanged: (text) => currentText = text,
                  clearOnSubmit: false,
                  textSubmitted: (text) => setState(() {
                    if (text.trim().isNotEmpty) {
                      setState(() {
                        nameCity = text.trim();
                        _lat = locationCity[nameCity][0];
                        _lon = locationCity[nameCity][1];
                        parseJson(http.Client(), _lat, _lon);
                      });
                    }
                  }
                  )
              ),
            ),

             showInfoWeather(_lat, _lon, nameCity),

            ],
          ),
        ),
      ),
    );
  }
}