import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontFamily: 'JuliusSansOne',
      color: Colors.white,
      fontSize: 18
    );
    const textStyle = TextStyle(
      fontFamily: 'Pacifico',
      color: Colors.white,
    );
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
            FormPerson(labelStyle: labelStyle, textStyle: textStyle)
          ]
        ),
        ),
      ),
    );
  }
}

class FormPerson extends StatefulWidget {
  const FormPerson({
    Key key,
    @required this.labelStyle,
    @required this.textStyle,
  }) : super(key: key);

  final TextStyle labelStyle;
  final TextStyle textStyle;

  @override
  _FormPersonState createState() => _FormPersonState();
}

class _FormPersonState extends State<FormPerson> {
  final _formKey = GlobalKey<FormState>();
  final _person1Controller = TextEditingController();
  final _person2Controller = TextEditingController();


  void _calculateLove() {
    // sembunyikan keypad
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    final full = (_person1Controller.text + _person2Controller.text).toLowerCase();
    var total = 0;
    for (var i = 0; i < full.length; i++) {
      total += full.codeUnitAt(i);
    }
    final result = total % 101;
    final snackBar = SnackBar(content: Text('Hasilnya Adalah: $result'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  @override
  void dispose() {
    super.dispose();
    _person1Controller.dispose();
    _person2Controller.dispose();
  }
  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 65, vertical: 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.all(6.0),
                  child: Text('Person 1', style: widget.labelStyle,)
                  ), 
                  InputPerson(labelStyle: widget.labelStyle, index: 1, controller: _person1Controller,),
                  Padding(padding: const EdgeInsets.only(top: 17, bottom: 15),
                  child: Text('Loves', style: widget.textStyle.copyWith(fontSize: 22))
                  ),
                  Padding(padding: const EdgeInsets.all(6.0),
                  child: Text('Person 2', style: widget.labelStyle,)
                  ),
                  InputPerson(labelStyle: widget.labelStyle, index: 2, controller: _person2Controller,),
                ],
              ),
            )
          )),
          Padding(
              padding: EdgeInsets.only(bottom: 75),
              child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    _calculateLove();
                  } 
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 65, vertical: 0),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xffbb1f50), Color(0xffe95d83)
                      ]
                    ),
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [ BoxShadow(
                      color: Colors.white.withAlpha(60),
                      blurRadius: 7,
                      spreadRadius: 2
                    )]
                  ),
                  child: Center(
                    child: Text('Calculate', style: widget.textStyle.copyWith(fontSize: 20))
                  ),
                ),
              ),
            )
        ]
      )
    );
  }
}

class InputPerson extends StatefulWidget {
  const InputPerson({
    Key key,
    @required this.labelStyle, this.index,
    @required this.controller
  }) : super(key: key);

  final TextStyle labelStyle;
  final int index;
  final TextEditingController controller;

  @override
  _InputPersonState createState() => _InputPersonState();
}

class _InputPersonState extends State<InputPerson> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.transparent,
          blurRadius: 7,
          spreadRadius: 1
        )
      ]
    ),
    child: TextFormField (
      controller: widget.controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Person ${widget.controller} must be not empty!';
        }
        return null;
      },
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      style: widget.labelStyle.copyWith(fontSize:16, color: Color(0xff55021e), fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20, vertical: 13 ),
          hintText: 'Person ${widget.index}',
          fillColor: Color(0xffdea8d0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.transparent)
          )                             
        ),
      )
    );
  }
}
