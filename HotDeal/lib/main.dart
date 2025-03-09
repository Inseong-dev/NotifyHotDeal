import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemList())
      ],
      child: MyApp(),
    )
  );
}

class ItemList with ChangeNotifier{
  List<HotDealItem> _items = [
    HotDealItem(items: "Hello1",),
    HotDealItem(items: "Hello2",),
    HotDealItem(items: "Hello3",),
    HotDealItem(items: "Hello4",),
    HotDealItem(items: "Hello5",),
  ];

  int getLength(){
    return _items.length;
  }
  void addItem(){
    _items.add(HotDealItem(items: "Hello"));
    notifyListeners();
  }
}


class HotDealItem extends StatefulWidget{
  final items;
  HotDealItem({required this.items});

  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(child:Text(items));
  // }
  @override
  State<HotDealItem> createState() => _HotDealItem();
}

class _HotDealItem extends State<HotDealItem>{
  @override
  Widget build(BuildContext context){
    return SizedBox(child: Text(widget.items),);
  }
}

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    ItemList list = Provider.of<ItemList>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("HotdealNotify",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              ),
              Row(
                children: [
                  IconButton(onPressed: () => list.addItem(), icon: const Icon(Icons.refresh)),
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
        body: Container(
          child: Consumer<ItemList>(
            builder: (BuildContext context, provider, child){
              return ListView.separated(
                itemCount: provider.getLength(),
                itemBuilder: (BuildContext context, int index){
                  return provider._items[index];
                },
                separatorBuilder: (BuildContext context, int index){
                  return Divider();
                }
              );
            }
          )
        ),
      ),
    );
  }
}

  