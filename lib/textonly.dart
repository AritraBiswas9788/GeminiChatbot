import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'CustomWidgets/botttext.dart';
import 'CustomWidgets/prompttext.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

class TextOnly extends StatefulWidget {
  const TextOnly({super.key});

  @override
  State<TextOnly> createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> {
  bool loading = false;

  void AsyncCall() async
  {
    await Future.delayed(Duration(seconds: 7));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[100],
        body: Column(
          children: [

            PromptText(prompt: "text Testing \n vgvuuhuhu \n niiijijij")
            ,
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        fillColor: Colors.transparent,
                      ),
                      maxLines: 4,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  Visibility(
                    visible: !loading,
                    child: IconButton(
                      icon: Icon(Icons.send_rounded,
                      color: Colors.green[700],
                      size: 40.0),
                      onPressed: () {
                        setState(() {
                          loading = true;
                          AsyncCall();
                        });
                      },
                    ),
                  ),
                  Visibility(visible: loading, child: SpinKitFadingCube(
                    color: Colors.green[700]!!,
                  ))
                ],
              ),
            )
          ],
        ));
  }
}
