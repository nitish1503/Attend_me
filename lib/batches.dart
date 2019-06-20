import 'package:attend_me/attendance.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Batches extends StatelessWidget {
  final _scafoldkey2 = GlobalKey<ScaffoldState>();
  final featureSnackBar =
      SnackBar(content: Text("This feature is not implemented yet"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Batches"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        print("Batches");
                        pushPage(context, Attendance(batch[index]));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          batch[index],
                          style:
                              TextStyle(color: Color(0xFF004B32), fontSize: 25),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF004B32),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: batch.length,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      print("Add Batch");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF004B32),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0)
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Add Batch", style: TextStyle(color: Color(0xFF004B32), fontSize: 20),),
                          Icon(Icons.add, color: Color(0xFF004B32), size: 40.0,),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
