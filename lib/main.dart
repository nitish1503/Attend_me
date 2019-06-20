import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SignupPage.dart';
import 'SigninPage.dart';
import 'batches.dart';

List<String> batch = ["3_CSE_B", "3_ME_A", "2_IT_A", "2_CSE_A", "2_IT_B"];
List<String> recent = ["3_CSE_B", "2_CSE_A"];

void pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.white,
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Attend_me',
      home: SigninPage(),
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
  final _scafoldkey = GlobalKey<ScaffoldState>();
  FirebaseUser user;

  final featureSnackBar =
      SnackBar(content: Text("This feature is not implemented yet"));
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      key: _scafoldkey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: <Widget>[
                  Container(
                    height: 220,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 16.0),
                    child: Image.asset("assets/illustration.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 25.0, 10.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/logo.png",
                          height: 30,
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Color(0xFF004B32),
                          ),
                          onPressed: () {
                            print("Settings");
                            _scafoldkey.currentState
                                .showSnackBar(featureSnackBar);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 2,
                color: Color(0xFF004B32),
              ),
              Container(
                alignment: Alignment.center,
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFFEAEAEA),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Good Morning",
                          style: TextStyle(
                            color: Color(0xFF004B32),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("Teacher!",
                          style: TextStyle(
                            color: Color(0xFF004B32),
                            fontSize: 30,
                          )),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(),
                          ),
                          InkWell(
                            onTap: () {
                              print("TAKE ATTENDANCE");
                              // _scafoldkey.currentState
                              //     .showSnackBar(featureSnackBar);
                              pushPage(context, Batches());
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFF004B32),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                ),
                              ),
                              child: Text(
                                "TAKE ATTENDANCE",
                                style: TextStyle(color: Colors.white),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 12.0, 25.0, 12.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Recents",
                      style:
                          TextStyle(color: Color(0xFF004B32), fontSize: 18.0),
                    )),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 20.0),
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        print("Recents");
                        _scafoldkey.currentState.showSnackBar(featureSnackBar);
                      },
                      child: Container(
                        height: 75,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Batch",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                recent[index],
                                style: TextStyle(
                                    color: Color(0xFF004B32), fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF004B32),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: recent.length,
            ),
          ),
        ],
      ),
    );
  }
}

