import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Data.dart';
import 'municipio.dart';
const apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkYW5pbWcwMkBvdXRsb29rLmVzIiwianRpIjoiNzYzMzg0NmEtZDEzMy00ZmMwLWI4MTMtOWM2ODBmNDBlMDJhIiwiaXNzIjoiQUVNRVQiLCJpYXQiOjE2NzcyMzUwMDUsInVzZXJJZCI6Ijc2MzM4NDZhLWQxMzMtNGZjMC1iODEzLTljNjgwZjQwZTAyYSIsInJvbGUiOiIifQ.xBIJxfCqm8I6cNdqdY6G6Ko6kpDIlpyKnqjfpFjI11A';

Future<void> fetchWeather(name) async {
    //Buscar en excel cod ciudad
  //final cityId = '15030'; // ID de A Coruña
  var cityId = "15030";
  var aux =getCityCode(name);
  if(aux!= null){
    cityId=aux as String;
  }

  // TODO: Chamar funcion busqueda sqlite

  //Si non encontra meter por defecto a Coruña TODO: Ou unha que seleccione o user ao principio


  final url = 'https://opendata.aemet.es/opendata/api/prediccion/especifica/municipio/diaria/$cityId/?api_key=$apiKey';

  final response = await http.get(Uri.parse(url));
  Data datos;
  if (response.statusCode == 200) {
    final dataUrl = jsonDecode(response.body)['datos'];
    final dataResponse = await http.get(Uri.parse(dataUrl));
    final weatherData = jsonDecode(dataResponse.body);
    var prediccion = weatherData[0]["prediccion"];
    var ciudad = weatherData[0]["nombre"];
    var dia = prediccion?["dia"];
    int hora = DateTime
        .now()
        .hour;
    var probPrecipitacion;
    probPrecipitacion = dia?[0]["probPrecipitacion"];
    var estadoCielo;
    estadoCielo = dia?[0]["estadoCielo"];
    var viento;
    viento = dia?[0]["viento"];
    var temperatura;
    temperatura = dia?[0]["temperatura"];
    var humedad;
    humedad = dia?[0]["humedadRelativa"];

    var valorPrecipitacion;
    var valorEstadocielo;
    var valorViento;
    var valorTemperaturaMAX;
    var valorTemperaturaMIN;
    var valorHumedadMAX;
    var valorHumedadMIN;

    int i = 0;
    if (hora > 0 && hora < 6) {
      i = 3;
    } else if (hora >= 6 && hora < 12) {
      i = 4;
    } else if (hora >= 12 && hora < 18) {
      i = 5;
    } else {
      i = 6;
    }
    valorPrecipitacion = probPrecipitacion[i]["value"];
    valorEstadocielo = estadoCielo[i]["descripcion"];
    valorViento = viento[i]["velocidad"];
    valorTemperaturaMAX = temperatura["maxima"];
    valorTemperaturaMIN = temperatura["minima"];
    valorHumedadMAX = humedad["maxima"];
    valorHumedadMIN = humedad["minima"];

    datos = Data(
        ciudad,
        valorPrecipitacion,
        valorEstadocielo,
        valorViento,
        valorHumedadMAX,
        valorHumedadMIN,
        valorTemperaturaMAX,
        valorTemperaturaMIN);

    // Trabajar con la información de la predicción meteorológica
  } else {
    throw Exception('Error al obtener la predicción meteorológica: ${response
        .statusCode}');
  }
  //petición chat
  var genero = "mujer";
  String peticion = "hazme un texto para una predicción del tiempo para la ciudad de ${datos.nombre} con temperatura mínima de ${datos.temp_min} Cº grados y máxima de ${datos.temp_max} Cº grados "
    "con cielo ${datos.estado_cielo} y posibilidad de lluvia al ${datos.probabilidadprec} % y ${datos.humedad_max} % de humedad para una persona mayor de género $genero";

}
