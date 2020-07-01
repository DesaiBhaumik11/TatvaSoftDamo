import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tatvasoftdamo/ApiCall.dart';
import 'package:tatvasoftdamo/Modelclass.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Damo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future data;

  @override
  void initState() {
    setState(() {
      data = ApiCall().getData();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Users> user = snapshot.data;
                  return ListView.builder(
                      itemCount: user.length,
                      itemBuilder: (context, index) {
                        List<String> images = user[index].items;
                        print('${user[index].name} ,List length:${user[index].items.length}, Images List:${user[index].items}');
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage('${user[index].image}'),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        '${user[index].name}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                              Flexible(
                                flex: 0,
                                child: Container(
                                    child: setImages(images),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  Text(snapshot.error);
                }
                return Center(child: CircularProgressIndicator());
              },
            )));
  }
  Widget setImages (List images){
    if (images.length % 2 == 0){
      print("even no:${images.length}");
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(images.length, (index) {
              return  Container(
                child: Image.network('${images[index]}'),
              );
            }),
        ),
      );
    } else
      print("odd no:${images.length}");
      print("odd no:${images.length}");
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              child: Image.network('${images.elementAt(0)}', fit: BoxFit.cover,),
              width: double.maxFinite,
              height: 240,
            ),
          ),
          Visibility(
            visible: images.length == 1 ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left:8, right: 8, bottom: 8),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(images.length - 1, (index) {
                  List<String> image = images.sublist(1, images.length);
                  return  Container(
                    child: Image.network('${image[index]}'),
                  );
                }),),
            ),
          ),
        ],
      );
  }
}
