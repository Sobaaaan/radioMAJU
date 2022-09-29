import 'package:flutter/material.dart';
import 'package:testapp/main.dart';
import 'package:testapp/palette.dart';
import 'package:testapp/newscreen.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radio hpage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BackgroundImage()));
  }




class _MyHomePageState extends State<MyHomePage> {
  
   int _page = 2;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
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
bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,
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
            image: AssetImage("assets/images/hpage.png"),
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
              'assets/images/Group 3.png',
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
            const Text(
              'THIS IS A NEW SCREEEEEEEEEEEEEEEEEEEEEN',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, color: Colors.purple),
            ),
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
            children: <Widget>[   const Padding(
              padding: EdgeInsets.all(12.0),
            ),
              const ListTile(  
                leading: Icon(Icons.album, size: 60,color: Colors.white),  
                title: Text(  
                  'FM 97.1',  
                  style: TextStyle(fontSize: 30.0,color: Colors.white)  
                ),  
                subtitle: Text(  
                  'Best of MAJU RADIO.',  
                  style: TextStyle(fontSize: 18.0,color: Colors.white)  
                ),  
              ),   const Padding(
              padding: EdgeInsets.fromLTRB(0,0,0,1.0),
            ),
              
              
              //BUTTON TO NAVIGATE
              
              ButtonBar(  
                children: <Widget>[  
                  RaisedButton(
                onPressed: () {
            _navigateToNextScreen(context);
          },




                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromARGB(255, 162, 99, 248),
                        Color.fromARGB(255, 13, 114, 161),
                      ],
                    ),borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20,10,20,10),
                  child: const Text('Play'),
                ),),




                
                 
                  // RaisedButton(  
                  //   child: const Text('Pause'),  
                  //   onPressed: () {/* ... */},  
                  // ),  
                ],  
              ),  
            ],),
                              
                              
                              
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
                      // BoxShadow(
                      //   color:Colors.white ,
                      //   offset: const Offset(
                      //     5.0,
                      //     5.0,
                          
                      //   ),
                      //   blurRadius: 10.0,
                      //   spreadRadius: 2.0,
                      // ), //BoxShadow
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
            ), //SizedBox
















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
          ],
        ),
      ),

    
    );
    
  }
}
