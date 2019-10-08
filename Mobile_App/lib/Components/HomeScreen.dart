import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

DateTime currentBackPressTime;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
String mobileNumber;
String uid;

void initState() {
   loaddata();
    super.initState();
  }

loaddata() async{
  final prefs = await SharedPreferences.getInstance();
    mobileNumber = prefs.getString('mobileNo');
    uid = prefs.getString('uid');
}
FirebaseAuth _auth = FirebaseAuth.instance;

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
                         child: Image.asset('assets/logo_cri.png',fit: BoxFit.scaleDown, width: 500,height: 500,),
                        ),
                      ),
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text('AppTitle'))
              ],
            ),
          ),
        body: WillPopScope(
          onWillPop: onWillPop,

          child: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hi...!'),
              Text('Welcome to School App'),
              Text(uid==null?'':uid,style:TextStyle(fontSize: 18)),
              Text(mobileNumber==null?'':mobileNumber,style:TextStyle(fontSize: 18)),
              MaterialButton( 
              child: Text('Logout'),
              color: Colors.red,
              minWidth: 150,
              height: 45,
              splashColor: Colors.redAccent,
              textColor: Colors.white,
              highlightElevation: 1,
                shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.of(context).pushNamed('/Login');
                  },
              ),
            ],
          ),
            ),
          )
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
