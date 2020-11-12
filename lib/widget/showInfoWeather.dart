import 'package:http/http.dart' as http;
import '../parseJson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showInfoWeather(double _lat, double _lon, var nameCity) {
  return FutureBuilder(
    future: parseJson(http.Client(), _lat, _lon),
    builder: (context, snapshot) {
      if(snapshot.hasData) {
        if(snapshot.data != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              nameCity != null ? Text('$nameCity:  ') : Text('Не вдалось знайти назву вашого міста: '),

              snapshot.data.airTemperature != null ? Text(snapshot.data.airTemperature.toString()) : Container(),

              SizedBox(
                width: 10,
              ),
              snapshot.data.airTemperatureTomorrow != null ? Text(snapshot.data.airTemperatureTomorrow.toString()) : Container(),

              SizedBox(
                width: 10,
              ),

              snapshot.data.airTemperatureTwoDays != null ? Text(snapshot.data.airTemperatureTwoDays.toString()) : Container()

            ],
          );
        } else {
          return new CircularProgressIndicator();
        }
      } else {
        return new CircularProgressIndicator();
      }
    },
  );
}
