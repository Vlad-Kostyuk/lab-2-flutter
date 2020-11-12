import 'package:http/http.dart' as http;

String _protocol = 'https://';
String _host = 'api.met.no/weatherapi/locationforecast/2.0/compact?';

getWeatherApi(http.Client client, double _lat, double _lon) async {
  var _apiUrl = _protocol + _host + 'lat=' + _lat.toString() + '&' + 'lon=' + _lon.toString();
  var response = await client.get(_apiUrl);
  return response;
}
