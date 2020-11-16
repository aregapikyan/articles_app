import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetGridImages extends StatelessWidget {
  final List<String> _imageUrls;

  WidgetGridImages(this._imageUrls);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return GridTile(child: Image.network(_imageUrls[index]));
        }),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2));
  }
}
