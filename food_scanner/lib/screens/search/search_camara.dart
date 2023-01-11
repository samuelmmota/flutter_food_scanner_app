import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../scan/camara.dart';
import '../../main.dart';

class SearchCameraPage extends StatelessWidget {
  // final String imagePath;
//  const SearchPage({super.key, required this.imagePath});
  const SearchCameraPage({super.key});

/*  @override
  Widget build(BuildContext context) => Scaffold(
    appBar : AppBar(
      title: const Text("Searching Recipes"),
      backgroundColor: Colors.blue.shade700,
    ),
    drawer: const NavigationDrawer(),
    */

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "_title",
      home: SearchCameraPageWidget(),
    );
  }
}

class SearchCameraPageWidget extends StatefulWidget {
  const SearchCameraPageWidget({super.key});

  @override
  State<SearchCameraPageWidget> createState() => _SearchCameraPageWidgetState();
}

class _SearchCameraPageWidgetState extends State<SearchCameraPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text("Searching Recipes"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: _camscanTab()
    );
  }
}


Widget _camscanTab() {
  const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return Center(
    child: ElevatedButton.icon(
      onPressed: () {
        // Handle button press
        OpenCamera();
      },
      icon: Icon(Icons.camera),
      label: Text("Take a Photo"),
    ),
  );
}
