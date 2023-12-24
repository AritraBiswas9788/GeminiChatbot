import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geminichatbot/CustomWidgets/botttext.dart';
import 'package:geminichatbot/CustomWidgets/prompttext.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'CustomWidgets/promptimagetext.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

String apiKey = "AIzaSyAoThvv1BL4MmnpGV93IAO8-safpRPYTNs";

class TextWithImage extends StatefulWidget {
  const TextWithImage({super.key});

  @override
  State<TextWithImage> createState() => _TextWithImageState();
}

class _TextWithImageState extends State<TextWithImage> with AutomaticKeepAliveClientMixin{
  List history = [];
  String promptText = "";
  bool loading = false;
  bool isImageRequest = false;
  File? imageFile;
  final ImagePicker picker = ImagePicker();
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

  void logHistory(String role, String text, File? image) {
    setState(() {
      history.add({'role': role, 'text': text, 'image': image});
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
    logHistory("gemini", response, null);
  }

  Future<void> generateTextFromImage(String prompt,File image) async {
    String response = "";
    await gemini
        .generateFromTextAndImages(query: prompt, image: image)
        .then((value) => response = value.text)
        .catchError((error) => response = "Error Occurred: $error");
    loading = false;
    logHistory("gemini", response, null);
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
                  return (history[index]['role'] == "User") ? (history[index]['image'] == null)?PromptText(prompt: history[index]['text']):PromptImageText(prompt: history[index]['text'],imageFile: history[index]['image']):botText(text: history[index]['text']);


                }
            )
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    onChanged: (text){promptText=text;},
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
                IconButton(
                  icon: Icon(
                    isImageRequest == true
                        ? Icons.hide_image_rounded
                        : Icons.add_a_photo,
                    size: 30.0,
                    color: Colors.green[700],
                  ),
                  onPressed: () async {
                    if (isImageRequest == false) {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        imageFile = image != null ? File(image.path) : null;
                        if (image != null) {
                          isImageRequest = true;
                        }
                      });
                    }
                    else
                      {
                        setState(() {
                          imageFile = null;
                          isImageRequest = false;
                        });
                      }
                  },
                ),
                Visibility(
                  visible: !loading,
                  child: IconButton(
                    icon: Icon(Icons.send_rounded,
                        color: Colors.green[700], size: 40.0),
                    onPressed: () {
                      if(promptText.isNotEmpty) {
                        setState(() {
                          loading = true;
                          FocusManager.instance.primaryFocus?.unfocus();
                          String ptext = promptText;
                          File? pImage = imageFile;
                          logHistory("User", promptText,
                              isImageRequest ? imageFile : null);
                          textController.clear();
                          if(!isImageRequest)
                             generateText(ptext);
                          else
                            generateTextFromImage(ptext, pImage!);
                          isImageRequest=false;
                          imageFile=null;
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
      ),
      floatingActionButton: imageFile != null
          ? Container(
              margin: const EdgeInsets.only(bottom: 80),
              height: 150,
              child: Image.file(imageFile ?? File("")),
            )
          : null,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
