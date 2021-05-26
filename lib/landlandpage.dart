import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strawberry/vain/fitness.dart';
import 'package:strawberry/functions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth/signup.dart';
import 'profile.dart';

class landlandpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return profile();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class SignInPage extends StatelessWidget {
  TextEditingController email_ctrl = TextEditingController();
  TextEditingController password_ctrl = TextEditingController();
  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  Future<void> _signInEmail(email, password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          });

      // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {



    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: maincolor,
          title: Text(
            'Sign in',
            style: TextStyle(color: text_color),
          )),
      body: Center(
        child: Center(
          child: Container(
            height: height * 0.33,
            child: Column(
              children: [
                textform(email_ctrl, "email", false),
                textform(password_ctrl, "password", true),
                RaisedButton(
                    color: maincolor,
                    child: Text(
                      'Sign in',
                    ),
                    onPressed: () {
                      _signInEmail(
                          email_ctrl.text, password_ctrl.text, context);

                      password_ctrl.clear();
                    }),
                RaisedButton(
                    child: Text("sign up"),
                    color: Colors.white,
                    splashColor: maincolor,
                    focusElevation: 0,
                    elevation: 0,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => signuppage()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   Future<void> _signOut() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//     } catch (e) {
//       print(e); // TODO: show dialog with error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         actions: <Widget>[
//           FlatButton(
//             child: Text(
//               'Logout',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 color: Colors.white,
//               ),
//             ),
//             onPressed: _signOut,
//           ),
//         ],
//       ),
//     );
//   }
// }

textform(Control, text, trueorf) {
  return TextFormField(
    obscureText: trueorf,
    controller: Control,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: Colors.white, width: 1),
      ),
      hintText: text,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: maincolor),
      ),
      focusColor: Colors.amber,
    ),
    validator: (value) {},
  );
}
