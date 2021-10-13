import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store_data/home2.dart';
import './pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage2(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';

  @override
  void initState() {
    readJsonFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: readJsonFile(),
            builder: (BuildContext context, AsyncSnapshot<List<Pizza>> pizzas) {
              return ListView.builder(
                itemCount: (pizzas.data == null) ? 0 : pizzas.data!.length,
                itemBuilder: (BuildContext context, int position) {
                  return ListTile(
                    title: Text(pizzas.data![position].pizzaName),
                    subtitle: Text(pizzas.data![position].description),
                  );
                },
              );
            }));
  }

  String convertToJson(List<Pizza> pizzas) {
    String json = '[';
    for (var element in pizzas) {
      json += jsonEncode(element);
    }
    json += ']';
    return json;
  }

  Future<List<Pizza>> readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzalist.json');

    List myMap = jsonDecode(myString);

    List<Pizza> listOfMyPizzas = [];

    for (var element in myMap) {
      Pizza myPizza = Pizza.fromJson(element);
      listOfMyPizzas.add(myPizza);
    }

    String json = convertToJson(listOfMyPizzas);

    return listOfMyPizzas;

    //setState(() {
    //  pizzaString = myString;
    //});
  }
}
