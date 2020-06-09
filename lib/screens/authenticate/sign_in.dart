import 'package:final_binder/services/auth.dart';
import 'package:final_binder/shared/loading.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
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
                    height: 60,
                    width: double.infinity,
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an Email Id' : null,
                      onChanged: (val){
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: primaryblue,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.grey[300]),
                          ),
                          hintText: 'Email Id',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter a password' : null,
                      obscureText: true,
                      onChanged: (val){
                        setState(() => password = val);
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: primaryblue,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.grey[300]),
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: BorderSide(color: primaryblue,width: 1.5)
                    ),
                    color: primaryblue,
                    textColor: Colors.white ,
                    child: loading ? Loading() : Text(
                        'SignIn'
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.singnInUsingEmail(email, password);
                        if(result == null){
                          setState(() {
                            error = "Enter valid Personal Id/Password.";
                            loading = false;
                          });
                        }else{
                          setState(() {
                            error = "";
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    error,
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
