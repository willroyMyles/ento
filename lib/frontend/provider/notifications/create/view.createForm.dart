import 'dart:io';

import 'package:ento/backend/enums/formType.dart';
import 'package:ento/frontend/provider/notifications/create/state.createForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateFormView extends StatelessWidget {
  final String formType;
  final Rx obj;
  final Function? submit;
  final Function? setSubmit;
  CreateFormView({
    Key? key,
    required this.formType,
    required this.obj,
    required this.submit,
    this.setSubmit,
  }) : super(key: key);
  final controller = Get.put(CreateFormState());

  @override
  Widget build(BuildContext context) {
    controller.formAndStatus(formType, submit, setSubmit);

    return Container(
      child: GetBuilder<CreateFormState>(
        builder: (context) {
          if (controller.status.isLoading)
            return Container(
              child: Text("loading"),
            );

          if (controller.status.isSuccess)
            return Container(
              child: SingleChildScrollView(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(25),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  constraints: BoxConstraints(
                      minHeight: 300, maxHeight: Get.height * .65),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: controller.conts.length,
                        itemBuilder: (context, index) {
                          var e = controller.conts.keys.elementAt(index);
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

                          if (e.type == FormType.PICTURE)
                            return InkWell(
                              onTap: () {
                                controller.pickImage(e);
                              },
                              child: Container(
                                height: 300,
                                width: Get.width,
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image.file(File(e.value ?? ""))
                                            .image,
                                        fit: BoxFit.cover,
                                        repeat: ImageRepeat.noRepeat),
                                    color: Colors.grey.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text("picture"),
                              ),
                            );

                          return Container();
                        },
                      )),
                    ],
                  ),
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
