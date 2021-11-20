import 'package:blogapp/schduleNotification/homeSchdule.dart';
import 'package:blogapp/schduleNotification/services.dart';
import 'package:blogapp/vaccine/vaccinedes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class vaccine extends StatefulWidget {
  final String vaccin;
  const vaccine({Key key, this.vaccin}) : super(key: key);

  @override
  _vaccineState createState() => _vaccineState();
}

class _vaccineState extends State<vaccine> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String vaccin = widget.vaccin;

    return Scaffold(
      appBar: _appbar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _showData(vaccin),
        ],
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),

      // myButton(label: "+ Add Task", onTap: () => null),
    );
  }

  _showData(String vaccin) {
    return Expanded(
        child: FutureBuilder(
            future: vaccineget(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      // ignore: missing_return
                      itemBuilder: (context, i) {
                        print(snapshot.data[i]['name']);

                        return AnimationConfiguration.staggeredList(
                            position: i,
                            child: SlideAnimation(
                                child: FadeInAnimation(
                                    child: Row(children: [
                              GestureDetector(
                                  onTap: () {
                                    print(snapshot.data[i]['description']);
                                    gotodetails(snapshot.data[i]['description']);
                                    
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(bottom: 12),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      //  width: SizeConfig.screenWidth * 0.78,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.blueGrey[200],
                                      ),
                                      child: Row(children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data[i]['name'] ?? "",
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.medical_services,
                                                    color: Colors.grey[200],
                                                    size: 18,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    snapshot.data[i]['datt'] ??
                                                        "",
                                                    style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.grey[100]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 60,
                                          width: 0.5,
                                          color:
                                              Colors.grey[200].withOpacity(0.7),
                                        ),
                                        RotatedBox(
                                          quarterTurns: 3,
                                          child: Text(
                                            "",
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  )),
                            ]))));
                      })
                  : Center(child: CircularProgressIndicator());
            }));
  }

  _appbar() {
    return AppBar(
      elevation: 0,
      //backgroundColor: context.themes.backgroundColor,
      // context.themes.backgroundColor,
      backgroundColor: Colors.grey,
      title: Text(
        "    Vaccine Table",
        style: Headingstyle,
      ),

      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color:  Colors.black,
          size: 20,
        ),
      ),
      actions: [
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Future vaccineget() async {
    var url = "http://192.168.232.2/Hi_Baby/vaccine.php";
    var respons = await http.get(url);
    var list = json.decode(respons.body);
    return list;
  }

  gotodetails(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => vaccinedes(id: id),
        ));
  }

  Future<String> getData(String username) async {
    var url = Uri.parse("http://192.168.232.2/Hi_Baby/getbaby.php");
    var map = new Map<String, dynamic>();
    map["username"] = username;
    var respons = await http.post(url, body: map);
    var list = json.decode(respons.body);
    //birth.add(list[0]['birthdat']);
    //print(birth);
  }
}
