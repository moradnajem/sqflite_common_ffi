import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sqflite/DB.dart';



void main(){
  WidgetsFlutterBinding.ensureInitialized();
  DB db = DB.instance;
  db.openDb();
  runApp(MaterialApp(
    home: new homepage(),
    debugShowCheckedModeBanner: false,
  ));
}


class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  DB db = DB.instance;



  /// =========================== Random Text For Insert ========================================
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  /// =========================== Random Text For Insert ========================================



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Wrap(
          children: [
            RaisedButton(
              onPressed: ()=> db.insert(
                {
                  'title': getRandomString(5)
                }
              ),
              textColor: Colors.white,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              elevation: 5,
              child: new Text(
                "insert",
              ),
            ),
            RaisedButton(
              onPressed: () => db.update(
                  id: 1,
                  map: {
                    'title': getRandomString(5)
                  }
                  ).then((value) => print(value)),
              textColor: Colors.white,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              elevation: 5,
              child: new Text(
                "update by id",
              ),
            ),
            RaisedButton(
              onPressed: ()=> db.delete(id: 1),
              textColor: Colors.white,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              elevation: 5,
              child: new Text(
                "delete by id",
              ),
            ),
            RaisedButton(
              onPressed: db.deleteAll,
              textColor: Colors.white,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              elevation: 5,
              child: new Text(
                "delete all",
              ),
            ),
            RaisedButton(
              onPressed: (){
                db.get(id: 1).then((value) => print(value));
              },
              textColor: Colors.white,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              elevation: 5,
              child: new Text(
                "get by id",
              ),
            ),
            RaisedButton(
              onPressed: (){
                db.getAll().then((value) => print(value));
              },
              textColor: Colors.white,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              elevation: 5,
              child: new Text(
                "get all",
              ),
            ),
            RaisedButton(
              onPressed: (){
                db.count().then((value) => print(value[0]["count"]));
              },
              textColor: Colors.white,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              elevation: 5,
              child: new Text(
                "count",
              ),
            ),
          ],
        ),
      ),
    );
  }

}
