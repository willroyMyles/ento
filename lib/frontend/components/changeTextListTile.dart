import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ChangeTextListTile extends StatelessWidget {
  final String? title;
  final String text;
  final ValueSetter<String> valueSetter;
  ChangeTextListTile(
      {Key? key, required this.text, this.title, required this.valueSetter})
      : super(key: key);

  final tec = TextEditingController();

  onPressed() async {
    var res = await Get.dialog(AlertDialog(
      backgroundColor: Colors.grey.shade100,
      content: Container(
          height: 200,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text("update $text"),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: tec,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 3))),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("cancel")),
                    TextButton(
                        onPressed: () {
                          Get.back(result: tec.text);
                        },
                        child: Text("update")),
                  ],
                ),
              )
            ],
          )),
    ));

    if (res != null && res != "") {
      valueSetter(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        onTap: () {
          onPressed();
        },
        // tileColor: Colors.blueGrey,
        title: Text("${title ?? 'none'}"),
        subtitle: Text("change $text"),
        trailing: Icon(Icons.edit),
      ),
    );
  }
}
