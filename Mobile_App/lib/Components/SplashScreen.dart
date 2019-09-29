import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome, rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}


class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
     Timer(Duration(seconds: 3), () => 
    _loadview()
     );
  }
  

  _loadview() async{
    final prefs =  await SharedPreferences.getInstance();
    final key = 'mobileNo';
    final value1 = prefs.getString(key) ?? 0;
    
    if(value1==0)
    {
      Navigator.popAndPushNamed(context, '/Login');
    }
    else
    {
      //  prefs.setString('mobileNo', null);
      Navigator.popAndPushNamed(context, '/Home');
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 98, 161, 74),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'logo_to_home',
                        child : CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 98, 161, 74),
                        radius: 100.0,
                        //backgroundImage: AssetImage('assets/logo_cri.png'),
                        child: Image.asset('assets/logo_cri.png',fit: BoxFit.scaleDown, width: 500,height: 500,),
                        ),
                      ),
                      Text(
                        'School Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}