import 'package:attend_me/SigninPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail, _userName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 150.0, 16.0),
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              //child: SvgPicture.asset('assets/Attend_me.svg', color: Colors.amber, ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 32.0),
                      child: TextField(controller: _nameController,
                      onChanged: (value) {
                        setState(() {
                         _userName = value; 
                        });
                      },
                        ),
                    ),
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
                          _register();
                          _emailController.clear();
                          _passwordController.clear();
                          _nameController.clear();
                        }
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      color: Color(0xFF004B32),
                    ),
                    Container(
                      child: Text(_success == null
                          ? ''
                          : (_success
                              ? 'Successfully registered ' + _userName
                              : 'Registration failed')),
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code for registration.
  void _register() async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ).then((signedinUser) {
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = _userName;
    });
    
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
        pushPage(context, SigninPage());
      });
    } else {
      _success = false;
    }
  }
}
