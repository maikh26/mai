import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doctor_detail.dart';

class imagelist extends StatelessWidget {
  final Title;
  final imagename;

  imagelist({this.Title, this.imagename, title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 130,
        width: 130,
        child: Card(
            child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.topLeft,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Row(children: <Widget>[
                            Container(
                              child: Text(
                                Title,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Image.network(
                                "http://172.20.10.4/Hi_Baby/uploads/$imagename")
                          ]),
                        )
                      ],
                    )))
          ],
        )),
      ),
    );
  }
}
