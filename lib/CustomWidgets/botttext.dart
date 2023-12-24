import 'package:flutter/material.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

class botText extends StatefulWidget {
  final String text;

  const botText({super.key, required this.text});

  @override
  State<botText> createState() => _botTextState();
}

class _botTextState extends State<botText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage('assets/chatbot.png'),
            height: 50.0,
            width: 50.0,
          ),
          SizedBox(width:25.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
              child: Text(widget.text),
            ),
          )
        ],
      ),
    );
  }
}
