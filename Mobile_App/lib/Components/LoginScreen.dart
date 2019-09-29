import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart';
import 'dart:developer';

DateTime currentBackPressTime;

class LoginScreen extends StatefulWidget {
 const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();
}
  
class LoginScreenState extends State<LoginScreen> {
  FocusNode myFocusNode;
  final myController = TextEditingController(); 

  

  getOtp()
  {
    var mobileNumber = myController.text;
    var count =  mobileNumber.length;
    // log('data: $count');
    if(count == 0)
    {
      Fluttertoast.showToast(
      msg: 'Enter Mobile Number',
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      ); 
      
    }
    else if (count < 10)
    {
      Fluttertoast.showToast(
      msg: 'Enter Valid Mobile Number',
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      );
    }
    else if(count == 10)
    {
     Fluttertoast.showToast(
      msg: 'OTP Sent..!',
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      );
      Navigator.of(context).pushNamed(
        '/Otp',
        arguments: mobileNumber,
      ); 
     // Navigator.pushNamed(context, '', arguments: (mobileNumber));
    }
  }
  checkOtp()
  {
    
  }

  Widget build(BuildContext context) {
    // timeDilation = 2.0;
    return Scaffold(
      // resizeToAvoidBottomPadding:false,
      body: WillPopScope(
          onWillPop: onWillPop,
      child: Stack(
            children: <Widget>[
             
             Container(
                child:  Image.asset('assets/background.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height, fit: BoxFit.cover), 
              ),

              Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                      Flexible(
                        child:  Hero(
                      tag: 'logo_to_home',
                      child : CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 98, 161, 74),
                        radius: 90.0,
                          child: Image.asset('assets/logo_cri.png',fit: BoxFit.scaleDown, width: 500,height: 500,),
                        )
                      ),
                      ),
                      Flexible(
                        child:  Padding(
                           padding: EdgeInsets.fromLTRB(25, 50, 25, 0),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                               TextFormField(
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                maxLength: 10,  
                                controller: myController,
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.phone_android,
                                      color: Colors.blueGrey,
                                      ), 
                                  ),
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(fontSize: 20),
                                  counterText: '',
                                  counterStyle: TextStyle(fontSize: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          )
                        ),
                      ),
                      Flexible(
                        child:
                        Padding(
                           padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              
                             MaterialButton( 
                                child: Text('Get OTP'),
                                padding: EdgeInsets.all(20.0),
                                color: Colors.green,
                                splashColor: Colors.greenAccent,
                                textColor: Colors.white,
                                minWidth: 150,
                                highlightElevation: 2,
                                 shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                onPressed: () => getOtp(),
                                ),
                            ],
                          )
                          ),
                        ),
                 ],
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



