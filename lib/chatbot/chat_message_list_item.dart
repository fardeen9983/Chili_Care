import 'package:flutter/material.dart';
import 'chat_messages.dart';

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage chatMessage;

  ChatMessageListItem(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: chatMessage.animationController, curve: Curves.easeOut),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                child: Text(chatMessage.initials ?? "JD"),
                backgroundColor: chatMessage.bot
                    ? Theme.of(context).accentColor
                    : Theme.of(context).highlightColor,
              ),
            ),
            Flexible(
                child: Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(chatMessage.name ?? "Jane Doe",
                            style: Theme.of(context).textTheme.subhead),
                        Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            child: Text(chatMessage.text))
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
