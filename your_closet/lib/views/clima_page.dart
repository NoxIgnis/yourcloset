import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:your_closet/services/weather_service.dart';

class ClimaPage extends StatefulWidget {

  ClimaPage ({Key?key}):super(key:key);

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {

    Position? _currentLocation;
    late bool servicePermission  = false;
    late LocationPermission permission;
    var temp;
    var description;
    var clima;
    late IconData iconed =Icons.wb_sunny;

  @override
  void initState() {
    // TODO: implement initState
    // _getCurrentLocation();
    // chamarFuncaoFirebase();
  }

    Future<Position?> _getCurrentLocation() async{
      servicePermission = await Geolocator.isLocationServiceEnabled();
      if(!servicePermission){
        print('servicePermission - disabled');
      }
      permission = await Geolocator.checkPermission();
       if(permission == LocationPermission.denied){
          permission = await Geolocator.requestPermission();
        }
        _currentLocation = await Geolocator.getCurrentPosition();
        await chamarFuncaoFirebase();
        print(_currentLocation);
      // return _currentLocation ;
    }

Future<void> chamarFuncaoFirebase() async {
  try {
    var client = http.Client();
    final uri = Uri.parse('http://localhost:5001/teste-yourcloset/us-central1/getClima');
    final response = await client.post(
      uri,
      body: {
        'latitude': _currentLocation!.latitude.toString(),
        'longitude': _currentLocation!.longitude.toString(),
      },
    );

    if (response.statusCode == 200) {
      
      Map<String, dynamic> resposta = json.decode(response.body);
      
      WeatherData weatherData = WeatherData.fromJson(resposta);
      temp = weatherData.temp;
      description =weatherData.description;
      clima = weatherData.main;
      setIcone(clima);
      // Accessing specific fields
      print('Main Weather: ${weatherData.temp}');
      print('Description: ${weatherData.description}');
      print('Description: ${weatherData.main}');
    } else {
      // Handle errors
      print('Error calling Firebase Function: ${response.statusCode}');
    }
  } catch (error) {
    // Handle exceptions during the HTTP call
    print('Error calling Firebase Function: $error');
  }
}

setIcone(clima){
  switch (clima) {
    case "Clear":
      iconed = Icons.wb_sunny;
      break;
    case "Thunderstorm":
      iconed = Icons.flash_on;
      break;
    case "Drizzle":
    case "Rain":
      iconed = Icons.beach_access; // Altere para o ícone de chuva desejado
      break;
    case "Snow":
      iconed = Icons.ac_unit;
      break;
    case "Clouds":
      iconed = Icons.cloud;
      break;
    default:
      iconed = Icons.wb_sunny;
  }
} 

   @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Clima',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              )
        ),
      ),
      body: FutureBuilder<Position?>(
      future: _getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
          return Center(
            child: snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Text('Erro: ${snapshot.error}'),
          );
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Clima',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    iconed,
                    size: 40,
                  ),
                ],
              ),
              SizedBox(height:5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    description,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height:5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Temperatura: '+temp.toStringAsFixed(0)+' ºC',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                ],
              ),                  
            ],
        )
        );
      }
      }
      ),
    );
  }
}