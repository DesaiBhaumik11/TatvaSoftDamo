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
      home: MyHomePage(title: 'Tatvasoft Damo'),
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
    data = ApiCall().getData();
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
                  print(snapshot.data['data']);
                  Map<String, dynamic> data = snapshot.data['data'];
                  List<dynamic> user = data['users'];
                  print(user);
                  return ListView.builder(
                      itemCount: user.length,
                      itemBuilder: (context, index) {
                        List<dynamic> images = user[index]['items'];
                        return Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage('${user[index]['image']}'),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      '${user[index]['name']}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                            Container(
                                child: setImages(images),
                            ),
                          ],
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
      return GridView.count(
        crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(images.length, (index) {
            return  Container(
              margin: EdgeInsets.all(10),
              child: Image.network('${images[index]}'),
            );
          }),
      );
    } else
      return Column(
        children: <Widget>[
          Container(
            child: Image.network('${images[0]}'),
            width: double.maxFinite,
            height: 200,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(images.length, (index) {
              return  Container(
                margin: EdgeInsets.all(10),
                child: Image.network('${images[index]}'),
              );
            }),),
        ],
      );
  }
}
