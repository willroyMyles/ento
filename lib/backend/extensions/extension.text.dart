import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as ta;

extension TextExtension on Text {
  date() {
    var time = ta.format(
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(this.data!) ?? 0),
        locale: "en_short");
    var style = this.style ?? TextStyle();
    var text = Text(
      time,
      maxLines: this.maxLines,
      overflow: this.overflow,
      softWrap: true,
      style: style.copyWith(color: Colors.grey.withOpacity(.8)),
      textAlign: this.textAlign,
      textScaleFactor: this.textScaleFactor,
    );

    return text;
  }
}
