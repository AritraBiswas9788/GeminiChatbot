import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geminichatbot/CustomWidgets/botttext.dart';
import 'CustomWidgets/prompttext.dart';
import 'CustomWidgets/botchat.dart';
import 'CustomWidgets/userchat.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

String apiKey = "AIzaSyAoThvv1BL4MmnpGV93IAO8-safpRPYTNs";

class TextChat extends StatefulWidget {
  const TextChat({super.key});

  @override
  State<TextChat> createState() => _TextChatState();
}

class _TextChatState extends State<TextChat> with AutomaticKeepAliveClientMixin {
  final List<Content> chats = [];
  String chat = "";
  bool loading = false;
  late Gemini gemini;
  final itemScrollController = ItemScrollController();
  final textController = TextEditingController();

  void initializeGeminiBot() {
    Gemini.init(apiKey: apiKey);
    gemini = Gemini.instance;
  }

  void logChats(String role, String text) {
    setState(() {
      chats.add(Content(
          role: role, parts: [Parts(text: text)]));
      if(chats.length>2) {
        itemScrollController.scrollTo(index: chats.length+1, duration: Duration(seconds: 1), curve: Curves.easeInOutCubic);
      }
    });
  }

  void generateChats() async
  {
    String response = "";
    await gemini.chat(chats).then((value) {
      response = value?.output ?? 'No Output Given';
    })
    .catchError((error) {response = "Error Occurred ${error}";});
    logChats('model', response);
    loading = false;
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
                    itemCount: chats.length,
                    itemBuilder: (context,index)
                    {
                      return (chats[index].role == "user") ? UserChat(chat: chats[index].parts?.lastOrNull?.text?? 'No data Found!'):BotChat(chat: chats[index].parts?.lastOrNull?.text?? 'No data Found!');
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
                        chat = text;
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
                        if(chat.isNotEmpty) {
                          setState(() {
                            FocusManager.instance.primaryFocus?.unfocus();
                            String p = chat;
                            logChats("user", chat);
                            textController.clear();
                            loading = true;
                            generateChats();

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
