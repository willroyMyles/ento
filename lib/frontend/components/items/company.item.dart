import 'package:ento/backend/models/Company.dart';
import 'package:flutter/material.dart';

class CompanyItem extends StatelessWidget {
  final Company model;
  const CompanyItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      // shadowColor: Colors.pinkAccent.shade100,
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(2),
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [Text(model.name), Text(model.email)],
        ),
      ),
    );
  }
}
