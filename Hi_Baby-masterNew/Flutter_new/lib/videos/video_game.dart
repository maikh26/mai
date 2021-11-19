// TODO Implement this library.
import 'dart:convert';
import 'dart:math';
//import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
//import 'package:video_player/video_player.dart';
import "colors.dart" as color;
import 'home_page.dart';

//import 'home_page.dart';
class videogame extends StatefulWidget {
  const videogame({Key key}) : super(key: key);

  @override
  _videogameState createState() => _videogameState();
}

class _videogameState extends State<videogame> {
  List videoInfo = [];
  bool _playArea = false;
  bool isplaying = false;
  bool _disposed = false;
  int _isplayingindex = -1;
  VideoPlayerController _controller;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videogame.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
    //_onTapVideo(-1);
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: _playArea == false
          ? BoxDecoration(
              gradient: LinearGradient(
              colors: [
                color.AppColor.gradientFirst.withOpacity(0.9),
                color.AppColor.gradientSecond
              ],
              begin: const FractionalOffset(0.0, 0.4),
              end: Alignment.topRight,
            ))
          : BoxDecoration(
              color: color.AppColor.secondPageTopIconColor,
            ),
      child: Column(
        children: [
          _playArea == false
              ? Container(
                  padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                              // Get.back();
                              // HomePage();
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline,
                              size: 20,
                              color: color.AppColor.secondPageIconColor),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Play with your baby",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: color.AppColor.secondPageTitleColor,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        padding:
                            const EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (route) => false);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            )
                          ],
                        ),
                      ),
                      _playvideo(context),
                      _controlview(context),
                    ],
                  ),
                ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Games can you play with your baby",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: color.AppColor.circuitsColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: _listview()),
              ],
            ),
          ))
        ],
      ),
    ));
  }

  String convertTow(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlview(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final head = _position?.inSeconds ?? 0;
    final duration = _duration?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTow(remained ~/ 60.0);
    final secs = convertTow(remained % 60);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[100],
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 2.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            thumbColor: Colors.redAccent,
            overlayColor: Colors.red,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.red[700],
            inactiveTickMarkColor: Colors.red[100],
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.redAccent,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
            )),
        child: Slider(
          value: max(0, min(_progress * 100, 100)),
          min: 0,
          max: 100,
          divisions: 100,
          label: _position?.toString().split(".")[0],
          onChanged: (Value) {
            setState(() {
              _progress = Value * 0.01;
            });
          },
          onChangeStart: (Value) {
            _controller?.pause();
          },
          onChangeEnd: (Value) {
            final duration = _controller?.value?.duration;
            if (duration != null) {
              var newValue = max(0, min(Value, 99)) * 0.01;
              var millis = (duration.inMilliseconds * newValue).toInt();
              _controller?.seekTo(Duration(milliseconds: millis));
              _controller?.play();
            }
          },
        ),
      ),
      Container(
        height: 40,
        margin: const EdgeInsets.only(bottom: 5),
        width: MediaQuery.of(context).size.width,
        color: color.AppColor.secondPageTopIconColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(50, 0, 0, 0),
                        )
                      ]),
                      child: Icon(
                        noMute ? Icons.volume_up : Icons.volume_off,
                        color: Colors.white,
                      )),
                ),
                onTap: () {
                  if (noMute) {
                    _controller?.setVolume(0);
                  } else {
                    _controller?.setVolume(1.0);
                  }
                  setState(() {});
                }),
            FlatButton(
                onPressed: () async {
                  final index = _isplayingindex - 1;
                  if (index >= 0 && videoInfo.length >= 0) {
                    _onTapVideo(index);
                  } else {
                    Get.snackbar("Videos", "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: color.AppColor.secondPageTopIconColor,
                        colorText: Colors.white,
                        messageText: Text(
                          "No more videos ahead",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ));
                  }
                },
                child: Icon(
                  Icons.fast_rewind,
                  size: 36,
                  color: Colors.white,
                )),
            FlatButton(
                onPressed: () async {
                  if (isplaying) {
                    setState(() {
                      isplaying = false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      isplaying = true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon(
                  isplaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                  color: Colors.white,
                )),
            FlatButton(
                onPressed: () async {
                  final index = _isplayingindex + 1;
                  if (index <= videoInfo.length - 1) {
                    _onTapVideo(index);
                  } else {
                    Get.snackbar("Video", "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: color.AppColor.secondPageTopIconColor,
                        colorText: Colors.white,
                        messageText: Text(
                          "You have finished watching all the videos",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ));
                  }
                },
                child: Icon(
                  Icons.fast_forward,
                  size: 36,
                  color: Colors.white,
                )),
            Text(
              "$mins:$secs",
              style: TextStyle(color: Colors.white, shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 4.0,
                  color: Color.fromARGB(150, 0, 0, 0),
                )
              ]),
            )
          ],
        ),
      ),
    ]);
  }

  Widget _playvideo(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text(
            "Preparing.....",
            style: TextStyle(fontSize: 20, color: Colors.white60),
          )));
    }
  }

  var _controllerupdateTime;
  Duration _duration;
  Duration _position;
  var _progress = 0.0;

  void _controllerupdate() async {
    if (_disposed) {
      return;
    }
    var _controllerupdateTime = 0;

    final now = DateTime.now().millisecondsSinceEpoch;
    if (_controllerupdateTime > now) {
      return;
    }
    _controllerupdateTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }

    if (!controller.value.isInitialized) {
      debugPrint("controller con not be initialized");
      return;
    }
    if (_duration == null) {
      _duration = _controller?.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;
    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    if (playing) {
      if (_disposed) return;
      setState(() {
        _progress = position.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    isplaying = playing;
  }

  _onTapVideo(int index) async {
    final controller =
        VideoPlayerController.network(videoInfo[index]["videoUrl"]);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_controllerupdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isplayingindex = index;
        controller.addListener(_controllerupdate);
        controller.play();
        setState(() {});
      });
  }

  _listview() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: videoInfo.length,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () {
              _onTapVideo(index);
              debugPrint(index.toString());
              setState(() {
                if (_playArea == false) {
                  _playArea = true;
                }
              });
            },
            child: _buildcard(index),
          );
        });
  }

  _buildcard(int index) {
    return Container(
      height: 80,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(videoInfo[index]["thumbnail"]))),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]["title"],
                    style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      videoInfo[index]["time"],
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _disbose {}
