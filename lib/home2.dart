import 'package:flutter/material.dart';
import 'package:store_data/httphelper.dart';
import 'package:store_data/pizza.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  void initState() {
    callPizzas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON')),
      body: FutureBuilder(
          future: callPizzas(),
          builder: (BuildContext context, AsyncSnapshot<List<Pizza>> pizzas) {
            return ListView.builder(
                itemCount: (pizzas.data == null) ? 0 : pizzas.data!.length,
                itemBuilder: (BuildContext context, int position) {
                  return ListTile(
                    title: Text(pizzas.data![position].pizzaName),
                    subtitle: Text(pizzas.data![position].description +
                        ' - € ' +
                        pizzas.data![position].price.toString()),
                  );
                });
          }),
    );
  }

  Future<List<Pizza>> callPizzas() async {
    HttpHelper helper = HttpHelper();
    List<Pizza> pizzas = await helper.getPizzaList();
    return pizzas;
  }
}
