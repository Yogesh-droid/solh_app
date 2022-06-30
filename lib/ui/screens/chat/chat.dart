import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            children: [
              ChatAppbar(),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: MessageBox(),
              ),
              Positioned(bottom: 20, child: MessageList())
            ],
          ),
        ),
      ),
    );
  }
}

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.black12)
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios_new),
            SizedBox(
              width: 6,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://180dc.org/wp-content/uploads/2016/08/default-profile.png'),
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              'Akriti handa',
              style: GoogleFonts.signika(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  MessageBox({Key? key}) : super(key: key);

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(
            color: SolhColors.green,
          ),
          borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write message',
                ),
              ),
            ),
            Icon(
              Icons.send,
              color: SolhColors.green,
            )
          ],
        ),
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  MessageList({Key? key}) : super(key: key);
  List message = [
    {
      'sender': 'user1',
      'message': 'Hii',
    },
    {
      'sender': 'user2',
      'message': 'Hello',
    },
    {
      'sender': 'user1',
      'message': 'How is everthing going!!',
    },
    {
      'sender': 'user2',
      'message': 'Everthing good , what about you?',
    },
    {
      'sender': 'user2',
      'message': 'Yeah ,good',
    },
    {
      'sender': 'user1',
      'message': "ooo...how's weather",
    },
    {
      'sender': 'user2',
      'message': 'So ...hot yaar!!',
    },
    {
      'sender': 'user2',
      'message': 'i have already took bath 2 times!!',
    },
  ];

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.message.length,
          itemBuilder: (context, index) {
            return MessageTile(
              message: widget.message[index]['message'],
              sender: widget.message[index]['sender'],
            );
          }),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required message, required sender})
      : _message = message,
        _sender = sender,
        super(key: key);

  final String _message;
  final String _sender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: SolhColors.green,
      ),
      child: Text(_message),
    );
  }
}
