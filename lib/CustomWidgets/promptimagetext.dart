import 'dart:io';

import 'package:flutter/material.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

class PromptImageText extends StatefulWidget {
  final String? prompt;
  final File? imageFile;
  const PromptImageText({super.key,this.prompt,this.imageFile});

  @override
  State<PromptImageText> createState() => _PromptImageTextState();
}

class _PromptImageTextState extends State<PromptImageText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightGreen[300]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black
                        ),
                        height: 150,
                        child: Image.file(widget.imageFile ?? File("")),
                      ),
                      SizedBox(height: 15.0),
                      Text(widget.prompt!!),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 25.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Image(
                    image: AssetImage('assets/problem.png'),
                    height: 60.0,
                    width: 60.0,
                  ),
                ],
              )
            ]
        ),
      ),
    );
  }
}



