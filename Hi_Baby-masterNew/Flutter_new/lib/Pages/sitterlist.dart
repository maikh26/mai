import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sitter_detail.dart';

class sitterlist extends StatelessWidget {
  final name;
  final detail;
  final location;

  final phone_num;

  sitterlist({
    this.name,
    this.detail,
    this.location,
    this.phone_num,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 130,
        width: 130,
        child: Card(
            child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Image.asset("assets/babysitter.jpg")),
            Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.topLeft,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        )),
                        Row(children: <Widget>[
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "Location : ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                location ?? 'default value',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              )
                            ],
                          )),

                          //  Text("time of work: 10-4"),
                        ]),
                      ],
                    )))
          ],
        )),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return sitterdetail(
            named: name,
            locationd: location,
            detaild: detail,
            phone_numd: phone_num,
          );
        }));
      },
    );
  }
}
