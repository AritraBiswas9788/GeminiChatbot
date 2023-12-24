import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String apiKey = "AIzaSyAoThvv1BL4MmnpGV93IAO8-safpRPYTNs";

class _HomeState extends State<Home> {
  String output = "";
  String prompt = "";
  late GoogleGemini geminiBot;

  @override
  void initState() {
    super.initState();
    initializeGeminiBot();
  }

  void initializeGeminiBot() {
    geminiBot = GoogleGemini(apiKey: apiKey);
  }

  Future<void> generateText(prompt) async {
    String response = "";
    await geminiBot
        .generateFromText(prompt)
        .then((value) => response = value.text)
        .catchError((error)=> response=error.toString());
    output=response;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.chat, color: Colors.white),
              SizedBox(width: 7.0),
              Text(
                "GEMINI CHATBOT",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(output),
            )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (text) {
                        prompt = text;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          hintText: "Enter Your Prompt here",
                          hintStyle: TextStyle(color: Colors.grey[900])),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (prompt.isNotEmpty) {
                          await generateText(prompt);
                          setState((){});
                        }
                      },
                      icon: Icon(
                        Icons.send_rounded,
                        size: 45.0,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
