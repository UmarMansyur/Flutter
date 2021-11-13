import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
         constraints: const BoxConstraints.expand(),
         decoration: const BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [
                Colors.pink, Colors.purple
             ]
           )
         ),
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Opacity(
              opacity: 0.1,
              child: Center(
                child: Container(
                  height: 450,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/heart.png'),
                      fit: BoxFit.contain
                    ),
                  )
                ),
              )
            ),
            Center(
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'The', style: TextStyle(fontFamily: 'Pacifico', fontSize:40)),
                    TextSpan(text: '\nLOVE\n', style: TextStyle(fontFamily: 'Poppins', fontSize:70, fontWeight: FontWeight.w900, color: Colors.white, height: 0.8)),
                    TextSpan(text: 'Calculator', style: TextStyle(fontFamily: 'Pacifico', fontSize:40, height: 1)),
                  ]
                )
              )
            )
          ]
        ),
        ),
      ),
    );
  }
}