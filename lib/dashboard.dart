import 'package:flutter/material.dart';

import 'textchat.dart';
import 'textonly.dart';
import 'textwithimage.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightGreen,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('assets/robot.png'),
                  width: 40.0,
                  height: 40.0),
                  SizedBox(width: 10.0),
                  Text(
                    "Gemini Chatbot",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              centerTitle: true,
              bottom: const TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: "Text Only"),
                  Tab(text: "Text & Image"),
                  Tab(text: "Text Chat"),
                ],
              ),
            ),
            body: Column(
              children: const [
                Expanded(
                  child: TabBarView(
                    children: [TextOnly(), TextWithImage(), TextChat()],
                  ),
                )
              ],
            )
        )
    );
  }
}
