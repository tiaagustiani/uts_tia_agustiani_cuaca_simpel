import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final String place;

  const Result({super.key, required this.place});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<Map<String, dynamic>> getDataFromAPI() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${widget.place}&appid=1b9c9a2f0595a56f5da50e6a664e9b66&units=metric"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    } else {
      throw Exception("Error!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
                "Hasil",
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
              backgroundColor: Colors.blueAccent,
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              )),
          body: Container(
            padding: EdgeInsets.only(left: 80, right: 80),
            child: FutureBuilder(
              future: getDataFromAPI(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  final data = snapshot.data!; // non nullable

                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: NetworkImage(
                                'https://flagsapi.com/${data["sys"]["country"]}/shiny/64.png')),
                        Text(
                          "${data["name"]}",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${data["weather"][0]["main"]}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${data["main"]["feels_like"]} °C",
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Kecepatan Angin: ${data["wind"]["speed"]} m/s",
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'Poppins'),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Text("Tempat tidak diketahui");
                }
              },
            ),
          )),
    );
  }
}
