import 'package:final_binder/services/auth.dart';
import 'package:final_binder/shared/loading.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../shared/themes.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  String email = null;
  String password = "";
  String error = "";
  bool loading = false;
  bool _showPassword = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context){
          return Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Loginbackground.png'),
                    fit: BoxFit.fill),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                            AssetImage('assets/Logo/LogoBlue/logoFullBlue.png'),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Sign in to continue.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: TextFormField(
                        validator: (val) =>
                        val.isEmpty
                            ? 'Enter an Email Id'
                            : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: primaryblue,
                            ),
//                            enabledBorder: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(4.0),
//                              borderSide: BorderSide(color: Colors.grey[300]),
//                            ),
                            hintText: 'Email Id',
                            hintStyle: TextStyle(color: Colors.grey)),
//                        controller: _email,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: TextFormField(
//                        controller: _pass,
                        validator: (val) =>
                        val.isEmpty
                            ? 'Enter a password'
                            : null,
                        obscureText: !_showPassword,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.enhanced_encryption,
                              color: primaryblue,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
//                            enabledBorder: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(4.0),
//                              borderSide: BorderSide(color: Colors.grey[300]),
//                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(color: primaryblue, width: 1.5)
                        ),
                        color: primaryblue,
                        textColor: Colors.white,
                        child: loading ? Loading() : Text(
                            'Sign in',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth.singnInUsingEmail(
                                email, password);
                            if (result == null) {

                              setState(() {
                                Scaffold.of(context).showSnackBar((SnackBar(
                                  content: new Text("Incorrect Email/ Password"),
                                  duration: Duration(seconds: 3),
                                )));
                                loading = false;
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: InkWell(
                          onTap: (){
                            if(email != null){
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "Reset Password?",
                                desc: "Would you like to reset password mail on ${email.toString()}?",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () async{
                                      await _auth.sendPasswordResetEmail(email);
                                      Navigator.pop(context);
                                      setState(() {
                                        error = "";
                                        Scaffold.of(context).showSnackBar((SnackBar(
                                          content: new Text("Please check your mailbox."),
                                          duration: Duration(seconds: 3),
                                        )));
                                      });
                                    },
                                    color: Color(0xFF1467B3),
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "No",
                                      style: TextStyle(color: Color(0xFF1467B3), fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    color: Colors.white,
                                  )
                                ],
                              ).show();
                            }
                            else if(email == null){
                              setState(() {
                                print('error');
                                error = "Enter your email Address";
                              });
                            }
                          },
                          child: Text(
                            'Forgot Password!',
                            style: TextStyle(
                              color: primaryblue,
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
      },)
    );
  }
}

