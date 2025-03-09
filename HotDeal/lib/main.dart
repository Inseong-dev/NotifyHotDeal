import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class ItemList with ChangeNotifier{
  List<HotDealItem> items = [];

  List<HotDealItem> get item => items;
}

class HotDealItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("HotdealNotizfy",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              ),
              Row(
                children: [
                  IconButton(onPressed: () => {}, icon: const Icon(Icons.refresh)),
                  Text("Refresh Time: ",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: ListView.builder(itemBuilder: itemBuilder)
        ),
      ),
    );
  }
}