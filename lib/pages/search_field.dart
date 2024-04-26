import 'package:cuaca3/pages/result.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Weather Today",
            style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Center(
            child: Container(
          padding: const EdgeInsets.only(left: 60, right: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                    hintText: "ketikkan nama kota (ex: Jakarta)"),
                style: const TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                controller: placeController,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Result(place: placeController.text);
                  }));

                  print(placeController.text);
                },
                child: const Text("Go"),
              )
            ],
          ),
        )),
      ),
    );
  }
}
