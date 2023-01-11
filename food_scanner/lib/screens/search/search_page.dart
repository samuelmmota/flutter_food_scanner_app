import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../scan/camara.dart';
import '../../main.dart';

class SearchPage extends StatelessWidget {
 // final String imagePath;
//  const SearchPage({super.key, required this.imagePath});
    const SearchPage({super.key});

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
      home: SearchPageWidget(),
    );
  }
}

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({super.key});

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    _searchTab(),
    _otherTab(),
    _camscanTab(),
  ];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text("Searching Recipes"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Cam Scan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 170, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _searchTab() {
  TextEditingController searchController = new TextEditingController();
  return Column(
    children: [
      TextField(
        onChanged: (text) {
          print('searching for => $text');
        },
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          hintText: 'Search Recipes name',
        ),
      ),
      TextButton(
        onPressed: (

            ) {
          print("this is the text to search for => ${searchController.text}");
        },
        child: Text("Search"),
      ),
    ],
  );
}

Widget _camscanTab() {

  const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return SizedBox(
    height: 40,
    child: TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blueAccent,
        padding: const EdgeInsets.all(12.0),
        textStyle: const TextStyle(fontSize: 12),
      ),
      onPressed: () {
        OpenCamera();
      },
      child: const Text('Open Camera'),
    ),
  );
}

Widget _otherTab() {
  const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return const Text(
    'Index 2: Business',
    style: optionStyle,
  );
}
