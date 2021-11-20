import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doctor_detail.dart';

class doclist extends StatelessWidget {
  final name;
  final work_place;
  final working_hours;
  final location;
  final rating;
  final detail;
  final phone_num;

  doclist({
    this.name,
    this.work_place,
    this.working_hours,
    this.location,
    this.rating,
    this.detail,
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
            Expanded(flex: 1, child: Image.asset("assets/doctor1.jpg")),
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
                                "Dr ",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                        Row(children: <Widget>[
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "work place : ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                work_place ?? 'default value',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              )
                            ],
                          )),

                          //  Text("time of work: 10-4"),
                        ]),
                        Row(children: <Widget>[
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Working hours : ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text(
                                working_hours,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              )
                            ],
                          )),

                          //  Text("time of work: 10-4"),
                        ]),
                        Row(children: <Widget>[
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(1),
                                child: Text(
                                  "location: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text(
                                location,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              )
                            ],
                          )),

                          //  Text("time of work: 10-4"),
                        ]),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(3),
                              child: Text(
                                rating,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ],
                    )))
          ],
        )),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return docdetail(
            named: name,
            work_placed: work_place,
            working_hoursd: working_hours,
            locationd: location,
            ratingd: rating,
            detaild: detail,
            phone_numd: phone_num,
          );
        }));
      },
    );
  }
}
