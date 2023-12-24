import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

class BotChat extends StatefulWidget {
  final String chat;
  const BotChat({super.key, required this.chat});

  @override
  State<BotChat> createState() => _BotChatState();
}

class _BotChatState extends State<BotChat> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Image(
                image: AssetImage('assets/chatbot.png'),
                height: 50.0,
                width: 50.0,
              )
            ],
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: ChatBubble(
              clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
              backGroundColor: Colors.lime,
              child: Text(widget.chat),
            ),
          ),
          SizedBox(width: 10.0,),

        ],
      ),

    );
  }
}
