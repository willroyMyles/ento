import 'package:ento/backend/enums/formType.dart';
import 'package:ento/frontend/provider/notifications/create/state.createForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateFormView extends StatelessWidget {
  final String formType;
  const CreateFormView({Key? key, required this.formType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateFormState(formType));

    return Container(
      child: GetBuilder<CreateFormState>(
        init: controller,
        builder: (state) {
          if (controller.status.isLoading)
            return Container(
              child: Text("loading"),
            );

          if (controller.status.isSuccess)
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                constraints:
                    BoxConstraints(minHeight: 300, maxHeight: Get.height - 300),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...controller.conts.keys.map((e) {
                          if (e.type == FormType.TEXT)
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              child: TextFormField(
                                controller: controller.conts[e],
                                onChanged: (value) {
                                  e.value = value;
                                },
                                decoration: InputDecoration(
                                  label: Text(e.placeHolder ?? ""),
                                ),
                              ),
                            );

                          return Container();
                        }).toList(),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              controller.submit();
                            },
                            child: Text("submit".toUpperCase()))
                      ]),
                ),
              ),
            );

          return Container(
            child: Text("eoty"),
          );
        },
      ),
    );
  }
}
