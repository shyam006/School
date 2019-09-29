import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpScreen extends StatefulWidget {
  final String value;
  OtpScreen({Key key, @required this.value}) : super(key: key);
  

  _OtpScreenState createState() => _OtpScreenState();
  
}

class _OtpScreenState extends State<OtpScreen> {
final myController = TextEditingController(); 
_login() async 
{
  var otp = myController.text;
  var count =  otp.length;
  if(count == 6)
  {
  final prefs = await SharedPreferences.getInstance();
  final key = 'mobileNo';
  final value = '7418373273';
  prefs.setString(key, value);
  Navigator.pushNamed(context, '/Home');
  }
  else if(count == 0){
     Fluttertoast.showToast(
      msg: 'Enter OTP...!',
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      ); 
  }
  else{
    Fluttertoast.showToast(
      msg: 'Invalid OTP...!',
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      );
  }
   
}
  @override
  Widget build(BuildContext context) {
    // timeDilation = 2.0;
    return Scaffold(
      body: Stack(
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
                           padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                     Text('+91- 7418373273',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
                              MaterialButton(
                                child: Icon(
                                      Icons.edit,
                                      color: Colors.blueGrey,
                                      ),
                                onPressed: (){Navigator.of(context).pop();},
                              )
                                  ],
                                ),
                              ),
                               TextFormField(
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                maxLength: 6,  
                                controller: myController,
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
                      Flexible(
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
                                onPressed: () => _login(),
                                ),
                            ],
                          )
                          ),
                        ),
                 ],
               ),

            ],
          ),
    );
  }
}