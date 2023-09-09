import 'package:calculator_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: CalculatorAPP(),
    );
  }
}

class CalculatorAPP extends StatefulWidget {
  const CalculatorAPP({super.key});

  @override
  State<CalculatorAPP> createState() => _CalculatorAPPState();
}

class _CalculatorAPPState extends State<CalculatorAPP> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB04759),
        title: Text("Calculator",
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.w600
        ),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column (
      children: [
        Expanded(
          child: Container(
                // color: Colors.orange,
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Input,
                    style: TextStyle(
                      fontSize: screenWidth * 0.09,
                      color: Colors.black,


                    ),),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                    Text(
                    Output,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.1,
                        color: const Color(0xff146C94),

                      ),),

                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                  ],
                ),
          ),
        ),

        Divider( // Add a divider here
          thickness: screenHeight * 0.005, // You can adjust the thickness as needed
          color: const Color(0xff146C94), // You can change the color of the divider
        ),

        // Buttons
        Row(
          children: [
            button(text: "AC",MyButtonColor: MyColors.operatorButtonColor ,txtColor: MyColors.operatorButtonTextColor ),
            button(text: "<-",MyButtonColor: MyColors.operatorButtonColor ,txtColor: MyColors.operatorButtonTextColor),
            button(text: "/",MyButtonColor: MyColors.operatorButtonColor),
          ],
        ),
        Row(
          children: [
            button(text: "7", ),
            button(text: "8",),
            button(text: "9",),
            button(text: "x",MyButtonColor: MyColors.operatorButtonColor),
          ],
        ),

        Row(
          children: [
            button(text: "4", ),
            button(text: "5",),
            button(text: "6",),
            button(text: "-",MyButtonColor: MyColors.operatorButtonColor),
          ],
        ),

        Row(
          children: [
            button(text: "1", ),
            button(text: "2",),
            button(text: "3",),
            button(text: "+",MyButtonColor: MyColors.operatorButtonColor),
          ],
        ),

        Row(
          children: [
            button(text: "%",MyButtonColor: MyColors.operatorButtonColor ),
            button(text: "0",),
            button(text: ".",),
            button(text: "=",MyButtonColor: MyColors.operatorButtonColor),
          ],
        ),
      ],
      ),
    );
  }

  // Build a row of buttons based on the given texts.
  Widget buildButtonRow(List<String> buttonTexts) {
    return Row(
      children: buttonTexts.map((text) {
        return button(text: text);
      }).toList(),
    );
  }

  var Input = '';
  var Output = '';

  onButtonClick(value){

    // if it is AC

    if(value == "AC"){
      Input = "";
      Output = "";
    }else if(value == "<-"){
      if(Input.isEmpty){
      }
      Input= Input.substring(0 , Input.length -1);
    }else if (value == "="){
      var userInput = Input;
      userInput = Input.replaceAll("x", "*");
      Parser P = Parser();
      Expression expression = P.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      Output = finalValue.toString();

    }else{
      Input = Input + value;
    }

    setState(() {

    });

  }


  // change the ui here

  Widget button({text, txtColor = Colors.white, MyButtonColor = MyColors.buttonColor}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyButtonColor,
            padding: EdgeInsets.all(screenWidth * 0.02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              color: txtColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => onButtonClick(text),
        ),
      ),
    );
  }
}
