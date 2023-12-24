import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

class UserChat extends StatefulWidget {
  final String chat;
  const UserChat({super.key, required this.chat});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 10.0,),
          Expanded(
            child: ChatBubble(
              alignment: Alignment.bottomRight,
              clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
              backGroundColor: Colors.lightGreen[300],
              child: Text(widget.chat),
            ),
          ),
          SizedBox(width: 10.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Image(
                image: AssetImage('assets/chat.png'),
                height: 50.0,
                width: 50.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}

