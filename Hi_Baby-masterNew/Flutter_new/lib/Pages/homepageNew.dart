import 'package:blogapp/Profile/ProfileScreen.dart';
import 'package:blogapp/group.dart';
import 'package:blogapp/schduleNotification/homeSchdule.dart';
import 'package:blogapp/vaccine/vaccine.dart';
import 'package:blogapp/videos/home_page.dart';
import 'package:flutter/material.dart';

import 'baby _sitter.dart';
import 'doctor.dart';
import 'gallary.dart';
import 'shapedashboard.dart';

class MyDashboard extends StatelessWidget {
  
  const MyDashboard({Key key, String username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50, // Set this height

        backgroundColor: Colors.pink[300],
        title: Text(
          "",
          //"${AgeCalculator.age(bodd, today: DateTime.now()).years.toString()} years |${AgeCalculator.age(bodd, today: DateTime.now()).months.toString()} Months | ${AgeCalculator.age(bodd, today: DateTime.now()).days.toString()} Days",
          style: TextStyle(fontSize: 13),
        ),
      ),
      drawer: Drawer(),
      body: Stack(
        children: [
          ClipPath(
            clipper: ShapeDashboard(),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[Colors.pink[300], Colors.pink[300]],
              )),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 // const SizedBox(height: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        primary: false,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => gallery(),
                                  ),
                                );
                              },
                              splashColor: Colors.pink,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        "assets/memory.jpg",
                                      ),
                                    ),
                                    Text("Baby gallary"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              },
                              splashColor: Colors.blue,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage("assets/ola.jpg"),
                                    ),
                                    Text("Videos"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => doctor(),
                                  ),
                                );
                              },
                              splashColor: Colors.blue,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage("assets/baby_doc.jpg"),
                                    ),
                                    Text("Baby doctors"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => homeschdule(),
                                  ),
                                );
                              },
                              splashColor: Colors.blue,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage("assets/wite_note.jpg"),
                                    ),
                                    Text("Write Notes"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Baby_sitter(),
                                  ),
                                );
                              },
                              splashColor: Colors.blue,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage("assets/mother4.jpg"),
                                    ),
                                    Text("Baby Sitter"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => group(),
                                  ),
                                );
                              },
                              splashColor: Colors.blue,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage("assets/mother3.jpg"),
                                    ),
                                    Text("Mothers Group"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          /*Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => vaccine(),
                                  ),
                                );
                              },
                              splashColor: Colors.blue,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage("assets/mom.png"),
                                    ),
                                    Text("Vaccines"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => group(),
                                  ),
                                );
                              },
                              splashColor: Colors.blue,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage("assets/groth.jpg"),
                                    ),
                                    Text("Baby Development"),
                                  ],
                                ),
                              ),
                            ),
                          )*/
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
