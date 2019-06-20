import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignupPage.dart';
import 'main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.height / 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 150.0, 16.0),
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 32.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter some text';
                          }
                        },
                      ),
                    ),
                    Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 32.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter some text';
                          }
                        },
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _signInWithEmailAndPassword();
                          _emailController.clear();
                          _passwordController.clear();
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      color: Color(0xFF004B32),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_success == null
                          ? ''
                          : (_success
                              ? 'Successfully signed in ' + _userEmail
                              : 'Sign in failed\nPossible Reasons:\n1. No Internet Connection\n2. Wrong Password'), textAlign: TextAlign.center,),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      child: Text("don't have account? No worry!"),
                      alignment: Alignment.centerRight,
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignupPage()));
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        color: Color(0xFF004B32),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await _auth.signOut();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
          // Navigator.pop(context);
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => MyHomePage()));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        });
      } else {
        _success = false;
      }
    } catch (PlatformException) {
      setState(() {
       _success = false; 
      });
      print("WRONG PASSWORD!!!");
    }

  }
}
