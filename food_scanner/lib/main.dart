import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_scanner/screens/favorite_page.dart';
import 'package:food_scanner/screens/search/search.dart';
import 'package:food_scanner/screens/search/searchRecipe_page.dart';
import 'package:food_scanner/screens/search/search_camara.dart';
import 'package:food_scanner/screens/search/search_page.dart';
import 'screens/login_page.dart';
import 'package:food_scanner/screens/profile_page.dart';
import 'package:food_scanner/screens/scan/camara.dart';
import 'screens/home_page.dart';
void main() async {
  //--no-sound-null-safety
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CheckLogginState();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Recipe App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: LoginPage(),
    );
  }
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
                builder: (context) => HomePage(),
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
            leading: const Icon(Icons.search),
            title: const Text("Search Recipe"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                //builder: (context) => SearchPage(),
                builder: (context) => SearchRecipePage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Scan Recipes"),
            onTap: () {
              User? user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                //login sucessfull
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SearchCameraPage(),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorite Recipes"),
            onTap: () {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => FavoriteRecipesPage(
                    ),
                  ),
                );
              }
            },
          ),
          const Divider(color: Colors.black54),
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
