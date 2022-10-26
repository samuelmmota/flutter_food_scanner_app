import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:food_scanner/cards/fill_image_card.dart';

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  List<String> items = List.generate(
    15,
    (index) => 'Item ${index + 1}',
  );

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "infinite Scroll View",
          ),
        ),
        body: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.all(8),
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index < items.length) {
                final item = items[index];
                return ListTile(title: Text(item));
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      );

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future fetch() async {
    setState(() {
      items.addAll([
        "Item A",
        "Item B",
        "Item C",
        "Item D ",
      ]);
    });

    /*final url = Uri.parse('http://');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List newItems = json.decode(response.body);
      setState(() {
        items.addAll([
          "Item A",
          "Item B",
          "Item C",
          "Item D ",
        ]);
      });
    }
    */
  }
}


/**
 * class HomePageCards extends StatelessWidget {
  const HomePageCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      createcard(context, "tittle"),
                      const SizedBox(
                        height: 16,
                      ),
                      createcard(context, "tittle"),
                      const SizedBox(
                        height: 16,
                      ),
                      createcard(context, "tittle"),
                      const SizedBox(
                        height: 16,
                      ),
                      createcard(context, "tittle"),
                      const SizedBox(
                        height: 16,
                      ),
                      createcard(context, "tittle")
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

 */
 /*List<String> items = List.generate(
    10,
    (index) => "Item ${index + 1}",
  );
  List<Recipe> itemCards =
     List.generate(10, (index) => Recipe("Item ${index + 1}", ""));
  */