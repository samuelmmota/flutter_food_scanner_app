import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar : AppBar(
      title: const Text("Searching Recipes"),
      backgroundColor: Colors.blue.shade700,
    ),
    drawer: const NavigationDrawer(),
  ) ;

}