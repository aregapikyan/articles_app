import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DismissedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16),
        color: Colors.blueGrey,
        // Fixme use containers align property
        child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 50,
            )));
  }
}
