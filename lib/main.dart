import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final StreamController _dividerController = StreamController<int>();


  @override
  void dispose() {
    _dividerController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                SpinningWheel(
                  Image.asset('assets/spin.png',fit: BoxFit.cover,),
                  width: 500,
                  height: 500,
                  spinResistance: 0.2,
                  initialSpinAngle: _generateRandomAngle(),
                  dividers: 12,
                  onUpdate: _dividerController.add,
                  onEnd: _dividerController.add,
                ),
                Align(
                  alignment: Alignment.center,
                child: Icon(Icons.arrow_drop_down,size: 100,color: Colors.yellow,),)
              ],
            ),
            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context,snapshot){
                return snapshot.hasData ? BasicScore(snapshot.data) : Container();
              },
            )
          ],
        ),
      ),
    );


  }
  double _generateRandomAngle() => Random().nextDouble() * pi * 2;

}

class BasicScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '01',
    2: '02',
    3: '03',
    4: '04',
    5: '05',
    6: '06',
    7: '07',
    8: '08',
    9: '09',
    10: '10',
    11: '11',
    12: '12'
  };

  BasicScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 26));
  }
}
