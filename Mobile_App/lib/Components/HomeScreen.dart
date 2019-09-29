import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:school_app/Components/BottamNavyBar.dart';

DateTime currentBackPressTime;

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return   Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title:Row(    
                 children: [
                 Hero(
                        tag: 'logo_to_home',
                        child : CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 98, 161, 74),
                        radius: 20.0,
                        // backgroundImage: AssetImage('assets/logo_cri.png'),
                         child: Image.asset('assets/logo_cri.png',fit: BoxFit.scaleDown, width: 500,height: 500,),
                        ),
                      ),
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text('AppTitle'))
              ],
            ),
          ),
        // bottomNavigationBar: BottamNavyBar(),
        body: WillPopScope(
          onWillPop: onWillPop,
          // () async {
          //   Future.value(
          //       false);
          // }, //To disable back option

          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[

              //  TextField(
              //   autofocus: true,
              //     decoration: InputDecoration(
              //       hintText: 'Enter a search termasdadasdadasdasdasdasdasdasdasd',
              //     ),
              //   ),
               TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter Email",
                  )
                ),

            ],
          ),
        )
        );
  }
}

Future<bool> onWillPop() async {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(
      msg: "Press again to exit App..!",
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
    );
    return Future.value(false);
  } else {
    SystemNavigator.pop();
  }
  return null;
}
