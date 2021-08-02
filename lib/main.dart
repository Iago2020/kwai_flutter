import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import 'package:marquee/marquee.dart' as marq;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:vector_math/vector_math.dart' show radians;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  bool abo = false;
  bool foryou = true;
  bool play = false;
  VideoPlayerController _controller;
  AnimationController animationController;

  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  PageController foryouController = new PageController();

  AnimationController controller;
  AnimationController rotationController;

  AnimationController visibleController;

  Animation animation;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();

    rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 5));
    animationController.repeat();
    visibleController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _controller = VideoPlayerController.asset('assets/vod.mp4')
      ..initialize().then((value) {
        // _controller.play();
        // _controller.setLooping(true);
        setState(() {});
      });

    visibleController.forward();
    visibleController.repeat();

    rotationController.forward(from: 0.0); // it starts the animation
    rotationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          homescreen(),
          footer(),
          footerTop(),
          // animationMusic(),
        ],
      ),
    );
  }

  homescreen() {
    return PageView.builder(
        controller: foryouController,
        onPageChanged: (index) {
          setState(() {
            _controller.seekTo(Duration.zero);
            _controller.play();
          });
        },
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      if (play) {
                        _controller.pause();
                        play = !play;
                      } else {
                        _controller.play();
                        play = !play;
                      }
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: VideoPlayer(_controller),
                  )),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 70,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 150,
                    padding: EdgeInsets.only(right: 50, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50.0)),
                              child: Image.asset(
                                'assets/pessoa.png',
                                height: 40,
                                width: 40,
                                cacheWidth: 200,
                                cacheHeight: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Javier1988',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.fromLTRB(15, 0, 15, 0)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.white))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: null,
                                child: Text(
                                  'Seguir',
                                  style: TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                        Text(
                          'Se só pudermos nos encontrar em vez de ficarem juntos@Alhei...#One Piece',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              animationMusic(),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: SizedBox(
                                  width: 80,
                                  height: 40,
                                  child: marq.Marquee(
                                    text:
                                        'Some sample text that takes some space.',
                                    style: TextStyle(color: Colors.white),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    blankSpace: 20.0,
                                    velocity: 100.0,
                                    pauseAfterRound: Duration(seconds: 1),
                                    startPadding: 10.0,
                                    accelerationDuration:
                                        Duration(milliseconds: 2500),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration:
                                        Duration(milliseconds: 2500),
                                    decelerationCurve: Curves.easeOut,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.tag_faces,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Dueto',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 65, right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 70,
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.favorite,
                                    size: 35, color: Colors.red),
                                Text('1557',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Icon(Icons.remove_circle,
                                        size: 35, color: Colors.white)),
                                Text('2051',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Icon(Icons.reply,
                                        size: 35, color: Colors.white)),
                                Text('260',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Icon(Icons.file_download,
                                    size: 35, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  animationMusic() {
    return Center(
      child: Container(
        //color: Colors.green,
        height: 60,
        width: 40,
        child: Stack(
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(rotationController),
              child: Stack(
                children: [
                  Stack(
                    children: [
                      //1
                      _buildButton(0, 0, 20,
                          color: Colors.green, icon: Icons.music_note),
                      // _buildButton(3, -15, 15,
                      //     color: Colors.purple, icon: FontAwesomeIcons.music),
                      // _buildButton(4, -18, 0,
                      //     color: Colors.orange, icon: Icons.ac_unit),
                      // _buildButton(5, -10, -15,
                      //     color: Colors.red,
                      //     icon: FontAwesomeIcons.accessibleIcon),
                    ],
                  ),
                  Stack(
                    children: [
                      // //2
                      // _buildButton(6, 2, -20,
                      //     color: Colors.blue,
                      //     icon: Icons.baby_changing_station),
                      _buildButton(7, 15, -15,
                          color: Colors.white,
                          icon: FontAwesomeIcons.calculator),
                      _buildButton(8, 20, 0,
                          color: Colors.pink, icon: Icons.dangerous),
                      _buildButton(9, 15, 15,
                          color: Colors.brown,
                          icon: FontAwesomeIcons.earlybirds),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, 0),
                child: Icon(
                  FontAwesomeIcons.music,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildButton(time, double x, double y, {Color color, IconData icon}) {
    //final double rad = radians(angle);
    return FadeTransition(
      opacity: visibleController.drive(CurveTween(curve: Curves.easeOut)),
      child: Align(
        alignment: Alignment.center,
        child: Transform.translate(
            offset: Offset(x, y), child: Icon(icon, size: 9, color: color)),
      ),
    );
  }

  videoSlider(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 372,
            width: Curves.easeInOut.transform(value) * 300,
            child: widget,
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: VideoPlayer(_controller),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 370 / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: AssetImage('assets/spook.png'),
                        radius: 30,
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child:
                          Text('Spook', style: TextStyle(color: Colors.white))),
                  Text('@spook_clothing',
                      style: TextStyle(color: Colors.white.withOpacity(0.5))),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 50, right: 50, top: 12),
                      decoration: BoxDecoration(
                        color: Color(0xfe2b54).withOpacity(1),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          'Abonnement',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  footer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //Divider(color: Colors.white.withOpacity(0.5)),
        Padding(
            padding: EdgeInsets.only(bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: Icon(Icons.home, color: Colors.white, size: 30)),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.history_toggle_off_outlined,
                        color: Colors.white.withOpacity(0.8), size: 30)),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: buttonplus()),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.notifications_none_outlined,
                        color: Colors.white.withOpacity(0.8), size: 30)),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Icon(Icons.person_outline_outlined,
                        color: Colors.white.withOpacity(0.8), size: 30)),
              ],
            ))
      ],
    );
  }

  footerTop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              child: DefaultTabController(
                length: 3,
                child: Material(
                  color: Colors.transparent,
                  child: TabBar(
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: Colors.white),
                        insets: EdgeInsets.symmetric(
                          horizontal: 40.0,
                        )),
                    labelStyle: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Family Name'), //For Selected tab
                    unselectedLabelStyle:
                        TextStyle(fontSize: 15.0, fontFamily: 'Family Name'),
                    tabs: [
                      Tab(
                        text: 'Seguindo',
                      ),
                      Tab(
                        text: 'Descubra',
                      ),
                      Tab(
                        text: 'Para você',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 25, 10, 0),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                )),
          ],
        ),
      ],
    );
  }

  buttonplus() {
    return Container(
      width: 60,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 20,
              height: 30,
              color: Colors.black,
            ),
          ),
          Center(
            child: Icon(
              Icons.camera_alt_sharp,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
