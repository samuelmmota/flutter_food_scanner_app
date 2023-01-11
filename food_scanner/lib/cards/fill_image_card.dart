import 'package:flutter/material.dart';
import 'package:food_scanner/models/recipeDataModel.dart';
import 'package:food_scanner/screens/detail_page.dart';
import 'image_card_content.dart';

class FillImageCard extends StatelessWidget {
  const FillImageCard({
    Key? key,
    this.width,
    this.height,
    this.heightImage,
    this.borderRadius = 6,
    this.contentPadding,
    required this.imageProvider,
    this.tags,
    this.title,
    this.description,
    this.footer,
    this.color = Colors.white,
    this.tagSpacing,
    this.tagRunSpacing,
    this.pathimageURL,
  }) : super(key: key);

  /// card width
  final double? width;

  /// card height
  final double? height;

  /// image height
  final double? heightImage;

  /// border radius value
  final double borderRadius;

  /// spacing between tag
  final double? tagSpacing;

  /// run spacing between line tag
  final double? tagRunSpacing;

  /// content padding
  final EdgeInsetsGeometry? contentPadding;

  /// image provider
  final ImageProvider imageProvider;

  /// list of widgets
  final List<Widget>? tags;

  /// card color
  final Color color;

  /// widget title of card
  final Widget? title;

  /// widget description of card
  final Widget? description;

  /// widget footer of card
  final Widget? footer;

  final String? pathimageURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
            child: Image.network(
              pathimageURL!,
              //image: pathimageProvider,
              width: width,
              height: heightImage,
              // fit: BoxFit.cover,
            ),
          ),
          ImageCardContent(
            contentPadding: contentPadding,
            tags: tags,
            title: title,
            footer: footer,
            description: description,
            tagSpacing: tagSpacing,
            tagRunSpacing: tagRunSpacing,
          ),
        ],
      ),
    );
  }
}

Widget _title({Color? color, String? title}) {
  return Text(
    title.toString(),
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
  );
}

Widget _content({Color? color, Recipe? recipe, BuildContext? context}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 161, 13, 13),
                  Color.fromARGB(255, 210, 25, 25),
                  Color.fromARGB(255, 245, 66, 66),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(12.0),
              textStyle: const TextStyle(fontSize: 12),
            ),
            onPressed: () {
              // _launchURL(sourceUrl!);
              Navigator.of(context!).push(MaterialPageRoute(
                  builder: (context) => RecipeDetail(recipe: recipe!)));
            },
            child: const Text('Open Recipe'),
          ),
        )
      ],
    ),
  );
}

Widget _footer({Color? color}) {
  return Row(
    children: [
      CircleAvatar(
        backgroundImage: AssetImage(
          'assets/avatar.png',
        ),
        radius: 12,
      ),
      const SizedBox(
        width: 4,
      ),
      Expanded(
          child: Text(
        'Super user',
        style: TextStyle(color: color),
      )),
      IconButton(onPressed: () {}, icon: Icon(Icons.share))
    ],
  );
}

Widget _tag(String tag, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.green),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        tag,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget createcard(BuildContext context, Recipe recipe) {
  return FillImageCard(
    width: 340,
    heightImage: 160,
    imageProvider: AssetImage(recipe.image),
    pathimageURL: recipe.image,
    tags: [_tag('Vegan', () {}), _tag('Vegetarian', () {})],
    title: _title(title: recipe.title),
    description: _content(recipe: recipe, context: context),
  );
}
