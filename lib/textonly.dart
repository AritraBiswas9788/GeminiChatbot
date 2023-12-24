import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geminichatbot/CustomWidgets/botttext.dart';
import 'CustomWidgets/prompttext.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

String apiKey = "AIzaSyAoThvv1BL4MmnpGV93IAO8-safpRPYTNs";

class TextOnly extends StatefulWidget {
  const TextOnly({super.key});

  @override
  State<TextOnly> createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> with AutomaticKeepAliveClientMixin {
  bool loading = false;
  List history = [];
  String promptText = "";
  late GoogleGemini gemini;
  final textController = TextEditingController();
  final itemScrollController = ItemScrollController();

  void AsyncCall() async {
    await Future.delayed(Duration(seconds: 7));
    setState(() {
      loading = false;
    });
  }

  void initializeGeminiBot() {
    gemini = GoogleGemini(apiKey: apiKey);
  }

  void logHistory(String role, String text) {
    setState(() {
      history.add({'role': role, 'text': text});

      if(history.length>2) {
        itemScrollController.scrollTo(index: history.length+1, duration: Duration(seconds: 1), curve: Curves.easeInOutCubic);
      }
    });
  }

  Future<void> generateText(prompt) async {
    String response = "";
    await gemini
        .generateFromText(prompt)
        .then((value) => response = value.text)
        .catchError((error) => response = "Error Occurred: $error");
    loading = false;
    logHistory("gemini", response);
  }

  @override
  void initState() {
    super.initState();
    initializeGeminiBot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[100],
        body: Column(
          children: [
            Expanded(
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  itemCount: history.length,
                    itemBuilder: (context,index)
                    {
                      return (history[index]['role'] == "User") ? PromptText(prompt: history[index]['text']):botText(text: history[index]['text']);
                    }
                )
            ),
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
                      controller: textController,
                      onChanged: (text){
                        promptText = text;
                      },
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
                          color: Colors.green[700], size: 40.0),
                      onPressed: () {
                        if(promptText.isNotEmpty) {
                          setState(() {
                            FocusManager.instance.primaryFocus?.unfocus();
                            String p = promptText;
                            logHistory("User", promptText);
                            textController.clear();
                            loading = true;
                            generateText(p);

                          });
                        }
                      },
                    ),
                  ),
                  Visibility(
                      visible: loading,
                      child: SpinKitFadingCube(
                        color: Colors.green[700]!!,
                      ))
                ],
              ),
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
