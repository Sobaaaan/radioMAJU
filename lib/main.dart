import 'package:flutter/material.dart';
import 'package:testapp/palette.dart';
import 'dart:math' show pi;
import 'package:radio_player/radio_player.dart';
import 'package:testapp/newscreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(BackgroundImage());
}

class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;

  PlayButton({
    required this.onPressed,
    this.initialIsPlaying = false,
    this.playIcon = const Icon(Icons.play_arrow),
    this.pauseIcon = const Icon(Icons.pause),
  }) : assert(onPressed != null);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);  
  static const _kRotationDuration = Duration(seconds: 5);

  late bool isPlaying;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));

    super.initState();
  }

  void _onToggle() {
    setState(() => isPlaying = !isPlaying);

    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }
	  
    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        icon: isPlaying ? widget.pauseIcon : widget.playIcon,
        onPressed: _onToggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(color: Color(0xff0092ff), scale: _scale, rotation: _rotation),
            Blob(color: Color(0xff4ac7b7), scale: _scale, rotation: _rotation * 2 - 30),
            Blob(color: Color(0xffa4a6f6), scale: _scale, rotation: _rotation * 3 - 45),
          ],
          Container(
            constraints: BoxConstraints.expand(),
            child: AnimatedSwitcher(
              child: _buildIcon(isPlaying),
              duration: _kToggleDuration,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
 
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}
class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radio hpage',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

///LOGIC FOR BUTTON PRESS
void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => NewScreen()));
}

class _MyHomePageState extends State<MyHomePage> {
 //selected page key for navbar
 int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata;
  @override
  void initState() {
    super.initState();
    initRadioPlayer();
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: 'Radio Player',
      url: 'http://mediaserv30.live-streams.nl:8086/live',
      imagePath: 'assets/cover.jpg',
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(50, 162, 109, 248),
      //   elevation: 0.0,
      //   title: Center(
      //     child: const Text(
      //       'Radio MAJU',
      //     ),
      //   ),
      // ),


// navbar 
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Color(0xEAEAE3E3),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),




      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/hpage1.png"),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Text(
            //   'Load image from assets',
            //   style: TextStyle(fontSize: 18.0),
            // ),
            const Padding(
              padding: EdgeInsets.only(bottom: 18.0),
            ),
            Image.asset(
              'assets/images/group31.png',
              height: 70,
              width: 70,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
            ),
            const Text(
              'MAJU  RADIO',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 150.0),
            ),
            // const Text(
            //   'THIS IS A TEST APP',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 18.0, color: Colors.purple),
            // ),
            const Padding(
              padding: EdgeInsets.all(12.0),
            ),

            Center(
              child: SizedBox(
                height: 160,
                width: 300,

                child: Container(
                  // image: const DecorationImage(
                  //   image: AssetImage(
                  //       'assets/images/maju.png'),
                  //   scale: 6.0,

                  // ), //DecorationImage
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                      ),
                      const ListTile(
                        leading:
                            Icon(Icons.album, size: 60, color: Colors.white),
                        title: Text('FM 97.6',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white)),
                        subtitle: Text('MAJU RADIO',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white)),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 1.0),
                      ),

                      //BUTTON TO NAVIGATE
ButtonBar(
                          children: <Widget>[
                      Center(
                        child: SizedBox(
                height: 50,
                width: 50,

                        child: SizedBox(
            height: 60,
            width: 60,
            child: PlayButton(
              pauseIcon: Icon(Icons.pause, color: Colors.black, size: 30),
              playIcon: Icon(Icons.play_arrow, color: Colors.black, size: 30),
              onPressed: () {isPlaying
                                    ? _radioPlayer.pause()
                                    : _radioPlayer.play();},
            ),
          ),
                        
                        // ButtonBar(
                        //   children: <Widget>[
                        //     ElevatedButton( 
                        //       onPressed: () {
                        //         isPlaying
                        //             ? _radioPlayer.pause()
                        //             : _radioPlayer.play();
                        //       },
                        //       // tooltip: 'Control button',
                        //       child: Icon( 
                        //         isPlaying
                        //             ? Icons.pause_rounded
                        //             : Icons.play_arrow_rounded,
                        //       ),
                        //       style: ElevatedButton.styleFrom(
                        //         primary: Color.fromARGB(255, 156, 80,
                        //             206), //change background color of button
                        //         onPrimary: Color.fromARGB(255, 255, 255,
                        //             255), //change text color of button
                        //         shape: CircleBorder(
                        //         ),
                        //         elevation: 15.0,
                        //         minimumSize: Size(80, 70),
                        //       ),
                        //       // child: Padding(
                        //       //   padding: const EdgeInsets.all(15.0),
                        //       //   child: Text(
                        //       //     'Play',
                        //       //     style: TextStyle(fontSize: 20),
                        //       //   ),
                        //       // ),
                        //     ),

                        //     // RaisedButton(
                        //     //   child: const Text('Pause'),
                        //     //   onPressed: () {/* ... */},
                        //     // ),
                        //   ],
                        // ),
                      ),


                      ///////////////////////BUTTON//////////////////
//             new ConstrainedBox(
//   constraints: new BoxConstraints(
//     minHeight: 5.0,
//     minWidth: 5.0,
//     maxHeight: 80.0,
//     maxWidth: 10.0,
//   ),
//   child: new DecoratedBox(
//     decoration: new BoxDecoration(color: Colors.red),
//   ),
// ),

            // Image.asset(
            //   'assets/images/maju.png',
            //   height: 70,
            //   width: 70,
            // ),
        ),],)
                    ],
                  ),

                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 0.0,
                        style: BorderStyle.solid), //Border.all

                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(144, 162, 109, 248),
                        Colors.transparent,
                        Colors.transparent,
                        Color.fromARGB(144, 162, 109, 248)
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0, 0, 0.1, 1],
                    ),

                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    //BorderRadius.only
                    /************************************/
                    /* The BoxShadow widget  is here */
                    /************************************/
                    boxShadow: const [
                      BoxShadow(
                        color:Colors.white ,
                        offset: const Offset(
                          0.0,
                          10.0,

                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Color.fromARGB(110, 118, 143, 236),
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ), //BoxDecoration
                ), //Container
              ),
            ), 
            
            
            //BUTTON
],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
      //   },
      //   tooltip: 'Control button',
      //   child: Icon(
      //     isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
      //   ),
      // ),
    );

    
  }
}
