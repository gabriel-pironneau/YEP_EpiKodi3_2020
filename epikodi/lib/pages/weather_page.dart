import 'package:epikodi/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  WeatherStation weatherStation;
  Weather weather;
  bool isSwitched;
  Future<bool> _counter;

  Map<String, IconData> _icon = {
    "Clouds": WeatherIcons.wiDayCloudy,
    "Rain": WeatherIcons.wiDayRain,
  };

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('meteob') ?? false);
    print('Pressed $counter times.');
    await prefs.setBool('meteob', !counter);
  }

  @override
  void initState() {
    super.initState();
    weatherStation = new WeatherStation("64a1ac19aed98c8f4311503a5470c468");
    getWeather();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('meteob') ?? false);
    });
  }

  Future<Weather> getWeather() async {
    weather = await weatherStation.currentWeather();
    print(weather);
    print(weather.weatherMain);
    print(weather.sunrise);
    //print(weather.cityName);
    return weather;
  }

  Future<bool> getValueMeteo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool counter = (prefs.getBool('meteob') ?? false);
    print('Pressed $counter times.');
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getValueMeteo(),
        builder: (BuildContext context, AsyncSnapshot<bool> snap) {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snap.hasError) {
                return Text('Error: ${snap.error}');
              } else {
                print(snap.data);
                isSwitched = snap.data;
                return Column(
                  children: <Widget>[
                    Row(
                      children: [
                        isSwitched
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    DateFormat('EEEE, d MMMM yyyy')
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 4,
                                        fontSize: 14),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(),
                              ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              _incrementCounter();
                              //print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent[400],
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                    FutureBuilder(
                      future: getWeather(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Weather> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container();
                            }
                        weather = snapshot.data;
                        return isSwitched
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    weather.areaName.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 5,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    weather.weatherDescription.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 5,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Icon(
                                    _icon[weather.weatherMain],
                                    size: 70,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '${weather.temperature.celsius.round()}°',
                                    style: TextStyle(
                                      fontSize: 100,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ValueTile("min",
                                          '${this.weather.tempMin.celsius.round()}°'),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Center(
                                            child: Container(
                                          width: 1,
                                          height: 30,
                                          color: Colors.grey[700],
                                        )),
                                      ),
                                      ValueTile("max",
                                          '${this.weather.tempMax.celsius.round()}°'),
                                    ],
                                  ),
                                  Padding(
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                    padding: EdgeInsets.all(10),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ValueTile("wind speed",
                                            '${this.weather.windSpeed} m/s'),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Center(
                                              child: Container(
                                            width: 1,
                                            height: 30,
                                            color: Colors.grey,
                                          )),
                                        ),
                                        ValueTile("sunrise",
                                            "${weather.sunrise.hour + 2}:${weather.sunrise.minute} AM"),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Center(
                                              child: Container(
                                            width: 1,
                                            height: 30,
                                            color: Colors.grey,
                                          )),
                                        ),
                                        ValueTile("sunset",
                                            "${weather.sunset.hour + 2}:${weather.sunset.minute} PM"),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Center(
                                              child: Container(
                                            width: 1,
                                            height: 30,
                                            color: Colors.grey,
                                          )),
                                        ),
                                        ValueTile("humidity",
                                            '${this.weather.humidity}%'),
                                      ]),
                                ],
                              )
                            : Center(
                                child: Container(
                                  child: Text('Météo désactiver'),
                                ),
                              );
                      },
                    ),
                  ],
                );
              }
          }
        });
  }
}
