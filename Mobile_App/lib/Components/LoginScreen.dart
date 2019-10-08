import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


DateTime currentBackPressTime;

class LoginScreen extends StatefulWidget {
 const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();
}
  
class LoginScreenState extends State<LoginScreen> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  bool otpSent =false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _mobileNumber;
  TextEditingController _otpCode;
  
  Future<void> verifyPhone() async {
    var mobileNumber = '+91'+this.phoneNo;
    var count =  this.phoneNo.length;
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
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      Fluttertoast.showToast(
        msg: 'OTP Sent..!',
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
       this.setState(() {
                otpSent = true;
        });  
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: mobileNumber,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent,
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
            storeData();
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
    }
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      storeData();
    } catch (e) {
      handleError(e);
    }
  }

  storeData() async{
    var uid='';
    final prefs = await SharedPreferences.getInstance();
    _auth.currentUser().then((user) {
      print(user);
       uid = user.uid;
       prefs.setString('mobileNo',this.phoneNo);
       prefs.setString('uid',uid);
       Navigator.of(context).pushNamed('/Home');
    });
    
    
  }

   handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
      Fluttertoast.showToast(
        msg: 'Invalid Verification Code..',
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
        break;
      default:
      Fluttertoast.showToast(
        msg: 'Please Try Again..',
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                     Visibility(
                       visible: !otpSent,
                       child: Flexible(
                        child:  Padding(
                           padding: EdgeInsets.fromLTRB(25, 50, 25, 0),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                               TextFormField(
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                maxLength: 10,  
                                controller: _mobileNumber,
                                onChanged: (value) {
                                  this.phoneNo = value;
                                },
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
                     ),
                     Visibility(
                       visible: !otpSent,
                       child: Flexible(
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
                                onPressed: () =>  verifyPhone(),
                                ),
                            ],
                          )
                          ),
                        ),
                     ),
                     Visibility(
                       visible: otpSent,
                       child: Flexible(
                        child:  Padding(
                           padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                child: Text(this.phoneNo== null?'':this.phoneNo,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700)),
                              ),
                              MaterialButton(
                                child: Icon(
                                      Icons.edit,
                                      color: Colors.blueGrey,
                                      ),
                                onPressed: (){
                                  _mobileNumber = TextEditingController(text: this.phoneNo);                                  
                                  this.setState(() {
                                      otpSent = false;
                                  });
                                },
                              )
                                  ],
                                ),
                              ),
                               TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _otpCode,
                                maxLength: 6, 
                                onChanged: (value) {
                                    this.smsOTP = value;
                                  }, 
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.sms,
                                      color: Colors.blueGrey,
                                      ), 
                                  ),
                                  hintText: 'OTP',
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
                     ),
                     Visibility(
                       visible: otpSent,
                       child: Flexible(
                        child:
                        Padding(
                           padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              
                             MaterialButton( 
                                child: Text('Login'),
                                padding: EdgeInsets.all(20.0),
                                color: Colors.green,
                                splashColor: Colors.greenAccent,
                                textColor: Colors.white,
                                minWidth: 150,
                                highlightElevation: 2,
                                 shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                onPressed: () {
                                       _auth.currentUser().then((user) {
                                      if (user != null) {
                                        storeData();
                                      } else {
                                        signIn();
                                      }
                                    });
                                      },
                                ),
                            ],
                          )
                          ),
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



