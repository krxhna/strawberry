import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strawberry/vain/fitness.dart';
import 'package:strawberry/functions.dart';
// import 'auth/signup.dart';
import 'package:strawberry/home.dart';

// class LandingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           User user = snapshot.data;
//           if (user == null) {
//             return SignInPage();
//           }
//           return HomePage();
//         } else {
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// class SignInPage extends StatelessWidget {
//   TextEditingController email_ctrl = TextEditingController();
//   TextEditingController password_ctrl = TextEditingController();

//   Future<void> _signInAnonymously() async {
//     try {
//       await FirebaseAuth.instance.signInAnonymously();
//     } catch (e) {
//       print(e); // TODO: show dialog with error
//     }
//   }

//   Future<void> _signInEmail(email, password, context) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       print(e);
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               content: Text(e.toString()),
//             );
//           });

//       // TODO: show dialog with error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text('Sign in')),
//       body: Center(
//         child: Container(
//           height: 300,
//           child: Column(
//             children: [
//               textform(email_ctrl, "email", false),
//               textform(password_ctrl, "password", true),
//               RaisedButton(
//                   color: maincolor,
//                   child: Text(
//                     'Sign in',
//                   ),
//                   onPressed: () {
//                     _signInEmail(email_ctrl.text, password_ctrl.text, context);

//                     password_ctrl.clear();
//                   }),
//               RaisedButton(
//                   child: Text("sign up"),
//                   color: Colors.white,
//                   elevation: 0,
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (BuildContext context) => signuppage()));
//                   })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// textform(Control, text, trueorf) {
//   return TextFormField(
//     obscureText: trueorf,
//     controller: Control,
//     textInputAction: TextInputAction.next,
//     keyboardType: TextInputType.emailAddress,
//     decoration: InputDecoration(
//       fillColor: Colors.white,
//       filled: true,
//       isDense: true,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: Colors.white, width: 1),
//       ),
//       hintText: text,
//       focusedBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: maincolor),
//       ),
//       focusColor: Colors.amber,
//     ),
//     validator: (value) {},
//   );
// }

class LandingPage extends StatelessWidget {
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
          return HomePage();
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
  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Center(
        child: RaisedButton(
          child: Text('Sign in anonymously'),
          onPressed: _signInAnonymously,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
