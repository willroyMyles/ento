import 'package:flutter/material.dart';

class Constants {
  static Widget empty(String text) {
    return Container(
      padding: EdgeInsets.all(50),
      alignment: Alignment.center,
      child: Text(
        text,
        maxLines: 2,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.grey.withOpacity(.5),
            fontSize: 30,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
