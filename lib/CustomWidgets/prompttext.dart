import 'package:flutter/material.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literal

class PromptText extends StatefulWidget {
  final String prompt;
  const PromptText({super.key, required this.prompt});

  @override
  State<PromptText> createState() => _PromptTextState();
}

class _PromptTextState extends State<PromptText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen[400]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.prompt),
            SizedBox(width: 25.0,),
            Image(
              image: AssetImage('assets/problem.png'),
              height: 60.0,
              width: 60.0,
            )
          ]
        ),
      ),
    );
  }
}
