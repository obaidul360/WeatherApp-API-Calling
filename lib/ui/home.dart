import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/service/api_service.dart';
import 'package:weather/ui/component/app_bar_drawer.dart';
import 'package:weather/ui/component/future_forecast_listitem.dart';
import 'package:weather/ui/component/hourly_weather_listitem.dart';
import 'package:weather/ui/component/todays_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService apiService = ApiService();
  final textEditingController = TextEditingController();
  String searchLocation = "auto:ip";

  _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Search Location"),
            content: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "Search by city, zip,lat,lang",
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    if (textEditingController.text.isEmpty) {
                      return;
                    }
                    Navigator.pop(context, textEditingController.text);
                  },
                  child: Text("OK")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Weather Flutter App"),
        actions: [
          IconButton(
              onPressed: () async {
                textEditingController.clear();
                String _text = await _showTextInputDialog(context);
                setState(() {
                  searchLocation = _text;
                });
              },
              icon: Icon(Icons.search,size: 30,)),
          SizedBox(width: 12,),
          IconButton(
              onPressed: () {
                searchLocation = "auto:ip";
                setState(() {});
              },
              icon: Icon(Icons.my_location,size: 30,)),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    image: DecorationImage(
                        image: AssetImage("image/obaidul.jpg"),
                        fit: BoxFit.cover)),
              ),
              Text(
                "Apps Developer",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Md Obaidul Islam",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "obdcse360@gmail.com",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              AppBarDrawer()
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getWeatherData(searchLocation),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TodaysWeather(
                      weatherModel: weatherModel,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Weather by Hours",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Hour? hour = weatherModel
                              ?.forecast?.forecastday?[0].hour?[index];
                          return HourlyWeatherListItem(
                            hour: hour,
                          );
                        },
                        itemCount: weatherModel
                            ?.forecast?.forecastday?[0].hour?.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Next 7 Days Weather",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Forecastday? forecastday =
                              weatherModel?.forecast?.forecastday?[index];
                          return FutureForecastListItem(
                            forecastday: forecastday,
                          );
                        },
                        itemCount: weatherModel?.forecast?.forecastday?.length,
                      ),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error has occured"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
