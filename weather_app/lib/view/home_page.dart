import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart' as k;

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
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: const Offset(1, 2),
                      blurRadius: 3,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Image(
                      image: const NetworkImage(
                          'https://rukminim1.flixcart.com/image/850/1000/k7285u80/digital-thermometer/y/e/t/thermocare-room-temperature-for-wall-mounting-yellow-thermometer-original-imafpe532fhgqq2y.jpeg?q=90'),
                      fit: BoxFit.fitHeight,
                      width: MediaQuery.of(context).size.width * 0.09,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Temperature: ${temp?.toInt()} ºC',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: const Offset(1, 2),
                      blurRadius: 3,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Image(
                      image: const NetworkImage(
                          'https://www.fluidpowerworld.com/wp-content/uploads/2015/06/Meg-pressure-gauge-drawing-image.jpg'),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.09,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Pressure: ${press?.toInt()} hPa',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: const Offset(1, 2),
                      blurRadius: 3,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Image(
                      image: const NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/3262/3262966.png'),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.09,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Humidity: ${hum?.toInt()} %',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: const Offset(1, 2),
                      blurRadius: 3,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Image(
                      image: const NetworkImage(
                          'https://i.pinimg.com/564x/7b/e2/18/7be218a3cf1708c6c5f628daf83a4718.jpg'),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.09,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'CloudCover: ${cover?.toInt()} %',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
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
      setState(() {
        isLoaded = true;
      });

      print(data);
    } else {
      print(response.statusCode);
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
      setState(() {
        isLoaded = true;
      });
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );
    if (p != null) {
      print('Lat:${p.latitude}, Long:${p.longitude}');
    } else {
      print('Data unavailable');
    }
  }
}
