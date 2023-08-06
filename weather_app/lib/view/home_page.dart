import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart' as k;

import '../utils/container_box_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  bool isLoaded = false;
  num? temp;
  num? press;
  num? hum;
  num? cover;
  String cityname = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 14, 14, 54),
                Color(0xff2BD2FF),
                Color(0xff2BFF88),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.09,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: Center(
                  child: TextFormField(
                    onFieldSubmitted: (String s) {
                      setState(() {
                        cityname = s;
                        getCityWeather(s);
                        isLoaded = false;
                        controller.clear();
                      });
                    },
                    controller: controller,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search city',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 25,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.pin_drop,
                      color: Colors.red,
                      size: 40,
                    ),
                    Text(
                      cityname,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ContainerBox(
                  cover: cover,
                  imageUrl:
                      'https://rukminim1.flixcart.com/image/850/1000/k7285u80/digital-thermometer/y/e/t/thermocare-room-temperature-for-wall-mounting-yellow-thermometer-original-imafpe532fhgqq2y.jpeg?q=90',
                  text: 'Temperature: ${temp?.toInt()} ºC'),
              ContainerBox(
                  cover: cover,
                  imageUrl:
                      'https://www.fluidpowerworld.com/wp-content/uploads/2015/06/Meg-pressure-gauge-drawing-image.jpg',
                  text: 'Pressure: ${press?.toInt()} hPa'),
              ContainerBox(
                  cover: cover,
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/3262/3262966.png',
                  text: 'Humidity: ${hum?.toInt()} %'),
              ContainerBox(
                cover: cover,
                imageUrl:
                    'https://i.pinimg.com/564x/7b/e2/18/7be218a3cf1708c6c5f628daf83a4718.jpg',
                text: 'CloudCover: ${cover?.toInt()} %',
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateUI(var decodedData) {
    setState(() {
      if (decodedData == null) {
        temp = 0;
        press = 0;
        hum = 0;
        cover = 0;
        cityname = 'Not available';
      } else {
        temp = decodedData['main']['temp'] - 273;
        press = decodedData['main']['pressure'];
        hum = decodedData['main']['humidity'];
        cover = decodedData['clouds']['all'];
        cityname = decodedData['name'];
      }
    });
  }

  getCityWeather(String cityname) async {
    var client = http.Client();
    var uri = '${k.domain}q=$cityname&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      updateUI(decodeData);
    }
  }

  getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      updateUI(decodeData);
    }
  }
}
