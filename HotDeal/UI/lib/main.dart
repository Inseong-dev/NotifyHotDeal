import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
  List<HotDealItem> _items = [];
  static int num = 0;
  int getLength(){
    return _items.length;
  }
  void addItem(){
    num++;
    if(_items.length < 10){
    _items.insert(0, HotDealItem(sitename: "siteName", price:100,url: "https://www.google.co.kr/",title: "ItemTitle" + num.toString()));  
    }
    else{
      _items.removeLast();
      _items.insert(0, HotDealItem(sitename: "siteName", price:100,url: "https://www.google.co.kr/",title: "ItemTitle" + num.toString()));
    }
    notifyListeners();
  }
}


class HotDealItem extends StatefulWidget{
  final String sitename;
  final int price;
  final String url;
  final String title;
  HotDealItem({
    required this.sitename,
    required this.price,
    required this.url,
    required this.title
    });

  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(child:Text(items));
  // }
  @override
  State<HotDealItem> createState() => _HotDealItem();
}

class _HotDealItem extends State<HotDealItem>{
 void launchBrowser() async{
  final url = Uri.parse(widget.url);
  if(await canLaunchUrl(url)){
    launchUrl(url);
  }
 }


  @override
  Widget build(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
            children: [
              Text(widget.title,
              style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber,

                    ),
                  ),
              Row(children: [
                Text(widget.sitename,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
                ),
                ),
                const Text("|") ,
                Text(widget.price.toString() + " 원 ",
                style: const TextStyle(
                  color: Colors.lightBlue,
                ),
                ),
                  ],
                ),
            ],
          ),
          IconButton(onPressed: launchBrowser, icon: Icon(Icons.link)),
        ],
      )
    );
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
                  const Text("Refresh Time: ",
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
        
          body: Consumer<ItemList>(
            builder: (BuildContext context, provider, child){
              return ListView.separated(
                itemCount: provider.getLength(),
                itemBuilder: (BuildContext context, int index){
                  return provider._items[index];
                },
                separatorBuilder: (BuildContext context, int index){
                  return const Divider();
                }
              );
            } 
        ),
      ),
    );
  }
}

  