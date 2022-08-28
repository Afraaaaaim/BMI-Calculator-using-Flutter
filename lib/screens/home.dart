import 'package:flutter/cupertino.dart';
import 'package:testproject/constants/app_constants.dart';
import 'package:testproject/widgets/left_bar.dart';
import 'package:testproject/widgets/right_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  double _bmiResult = 0;
  String _textResult = "";
  String _bmrResulttm = "";
  double _bmrResultm = 0;
  String _bmrResulttw = "";
  double _bmrResultw = 0;
  String _iWFl = "";
  String _iWFh = "";
  String _iWMl = "";
  String _iWMh = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI Calculator",
            style:
                TextStyle(color: accentHexColor, fontWeight: FontWeight.w300),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: mainHexColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 270,
                    child: TextField(
                      controller: _heightController,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w300,
                          color: accentHexColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Height(cm)",
                        hintStyle: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(.5)),
                      ),
                    ),
                  ),
                  Container(
                    width: 270,
                    child: TextField(
                      controller: _weightController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w300,
                          color: accentHexColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Weight(kg)",
                        hintStyle: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(.5)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 270,
                child: TextField(
                  controller: _ageController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      color: accentHexColor),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Age",
                    hintStyle: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(.5)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(accentHexColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(mainHexColor),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return mainHexColor.withOpacity(.25);
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed))
                        return accentHexColor.withOpacity(1);
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                onPressed: () {
                  double _h = double.parse(_heightController.text);
                  double _w = double.parse(_weightController.text);
                  double _a = double.parse(_ageController.text);
                  double _iWF = 0;
                  double _iWM = 0;
                  
                  setState(() {
                    _bmiResult = _w / (_h * _h / 10000);
                    _bmiResult.toStringAsFixed(2);
                    _bmrResultm = 5 + (10 * _w) + (6.25 * _h) - (5 * _a);
                    _bmrResulttm = _bmrResultm.toStringAsFixed(2);
                    _bmrResultw = -161 + (10 * _w) + (6.25 * _h) - (5 * _a);
                    _bmrResulttw = _bmrResultw.toStringAsFixed(2);

                    _iWF = 45.5 + (2.3 * ((_h * 0.393701)  - 60));
                    _iWM = 50 + (2.3 * ((_h * 0.393701)  - 60));
                    _iWMl = (_iWM-9).toStringAsFixed(2);
                    _iWMh = (_iWM+5).toStringAsFixed(2);
                    _iWFl = (_iWF-9).toStringAsFixed(2);
                    _iWFh = (_iWF+5).toStringAsFixed(2);

                    if (_bmiResult > 25 && _bmiResult <= 29) {
                      _textResult = "You\'re over weight";
                    } else if (_bmiResult >= 18.5 && _bmiResult <= 25) {
                      _textResult = "You have normal weight";
                    } else if (_bmiResult >= 30 && _bmiResult <= 34.4) {
                     _textResult = "You are class 1 Obese(low risk) ";
                    } else if (_bmiResult >= 35 && _bmiResult <= 39.9) {
                     _textResult = "You are class 2 Obese(med risk) ";
                    } else if (_bmiResult > 40 ) {
                     _textResult = "You are class 3 Obese(high risk) ";
                    } else {
                      _textResult = "You\'re under weight";
                    }
                  });
                },
                child: Container(
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Container(
                child: Text(
                  _bmiResult.toStringAsFixed(2),
                  style: TextStyle(fontSize: 60, color: accentHexColor),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Visibility(
                  visible: _textResult.isNotEmpty,
                  child: Container(
                    child: Text(
                      _textResult,
                      style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          color: accentHexColor),
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              Visibility(
                visible: _textResult.isNotEmpty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      
                      width: 450,
                      child: Text(
                        "Ideal weight for Men : $_iWMl - $_iWMh",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: accentHexColor),
                      ),
                    ),
                    Container(
                      width: 450,
                      child: Text(
                        "Ideal weight for Women: $_iWFl - $_iWFh",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: accentHexColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Visibility(

                visible: _textResult.isNotEmpty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 350,
                      child: Text(
                        "BMR of Men : $_bmrResulttm",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: accentHexColor),
                      ),
                    ),
                    Container(
                      width: 350,
                      child: Text(
                        "BMR of Women : $_bmrResulttw",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: accentHexColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              LeftBar(
                barWidth: 40,
              ),
              SizedBox(
                height: 20,
              ),
              LeftBar(barWidth: 70),
              SizedBox(
                height: 20,
              ),
              LeftBar(
                barWidth: 40,
              ),
              SizedBox(
                height: 20,
              ),
              RightBar(barWidth: 70),
              SizedBox(
                height: 50,
              ),
              RightBar(barWidth: 70),
            ],
          ),
        ));
  }
}
