


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopAskopenGpsIos extends StatelessWidget {
  final Function? onCancel;
  final Function? onGoSettings;
  const PopAskopenGpsIos({Key? key, this.onCancel, this.onGoSettings}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('خدمات الموقع'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('للاستمرار يجب عليك تفعيل خدمات الموقع من الاعدادات / الخصوصية / خدمات الموقع'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('الاعدادات'),
          onPressed: () {
            onGoSettings!();
          },
        ),
        TextButton(
          child: Text('الغاء'),
          onPressed: () {
            onCancel!();
          },
        ),
      ],
    );
  }
}


