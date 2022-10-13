import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_scanner/screens/search.dart';
import 'screens/login_page.dart';
import 'package:food_scanner/screens/profile_page.dart';

//void main() => runApp(const MainScreen());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CheckLogginState();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: LoginPage(),
    );
  }
}

/**
 *  
abstract class  _MyAppState extends State<MyApp> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //login sucessfull
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomgePage(
          ),
        ),
      );
    }

    return firebaseApp;
  }
  static const String _title = 'Flutter Code Sample';



  }

 */

class HomgePage extends StatelessWidget {
  const HomgePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.blue.shade700,
        ),
        drawer: const NavigationDrawer(),
      );
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ]),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
    );
Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomgePage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("User Information"),
            onTap: () {
              User? user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                //login sucessfull
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      user: user,
                    ),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Search Recipe"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SearchPage(),
              ));
            },
          ),
          const Divider(color: Colors.black54),
          /*   ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text("LogIn"),
        onTap: (){
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(),));
        },
      ), */
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LogOut"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                if (user == null) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    ModalRoute.withName('/'),
                  );
                }
              });
            },
          )
        ],
      ),
    );

Future CheckLogginState() async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}
