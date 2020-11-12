import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'api/api.dart';
import 'model/WeatherApi.dart';

double airTemperature;
double airTemperatureTomorrow;
double airTemperatureTwoDays;

bool dayNow = true;
bool dayTomorrow = true;
bool twoDays = true;

parseJson(http.Client client, double _lat, double _lon) async {
  var response = await getWeatherApi(client, _lat, _lon);
  var json = jsonDecode(response.body);
  var data = json['properties']['timeseries'];

  var days;

  data.forEach((jsonString) async {
    DateTime tempDate =
        new DateFormat("yyyy-MM-ddTHH:mmZ").parse(jsonString['time']);

    if (dayNow) {
      days = int.parse(DateFormat("dd").format(tempDate).toString());
      days = days + 1;

      dayNow = false;
      airTemperature = jsonString['data']['instant']['details']['air_temperature'];
    }

    if (dayTomorrow && int.parse(DateFormat("dd").format(tempDate)) == days) {
      days = days + 1;

      dayTomorrow = false;
      airTemperatureTomorrow = jsonString['data']['instant']['details']['air_temperature'];
    }

    if (twoDays && int.parse(DateFormat("dd").format(tempDate)) == days) {
      twoDays = false;
      airTemperatureTwoDays = jsonString['data']['instant']['details']['air_temperature'];
    }
  });

  dayNow = true;
  dayTomorrow = true;
  twoDays = true;

  return WeatherApi(
      airTemperature: airTemperature,
      airTemperatureTomorrow: airTemperatureTomorrow,
      airTemperatureTwoDays: airTemperatureTwoDays
  );
}
