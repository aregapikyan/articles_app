import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetImages extends StatelessWidget {
  final List<String> _imageUrls;

  WidgetImages(this._imageUrls);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: 150,
            margin: EdgeInsets.only(right: 2),
            child: Image.network(
              _imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: _imageUrls.length,
      ),
    );
  }
}
