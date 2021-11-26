import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doctor_detail.dart';

class doclist extends StatefulWidget {
  final name;
  final work_place;
  final working_hours;
  final location;
  final rating;
  final detail;
  final phone_num;
  final price;
  final image_gallary;

  doclist({
    this.name,
    this.work_place,
    this.working_hours,
    this.location,
    this.rating,
    this.detail,
    this.phone_num,
    this.price,
    this.image_gallary,
  });

  @override
  State<doclist> createState() => _doclistState();
}

class _doclistState extends State<doclist> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 200,
        width: 200,
        child: Card(
            child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.network(
                "http://172.20.10.4/Hi_Baby/doctors/${widget.image_gallary}",
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace stackTrace) {
                  return Icon(Icons.do_not_disturb);
                },
              ),
            ),
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
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "Dr ",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              widget.name,
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
                                widget.work_place ?? 'default value',
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
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "location: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text(
                                widget.location,
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
                                widget.rating,
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
              named: widget.name,
              work_placed: widget.work_place,
              working_hoursd: widget.working_hours,
              locationd: widget.location,
              ratingd: widget.rating,
              detaild: widget.detail,
              phone_numd: widget.phone_num,
              priced: widget.price,
              imageg: widget.image_gallary);
        }));
      },
    );
  }
}
