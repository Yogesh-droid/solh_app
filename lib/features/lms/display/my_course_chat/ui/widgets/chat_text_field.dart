import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField(
      {super.key,
      required this.onSendBtnTapped,
      required this.textEditingController});
  final Function(String text) onSendBtnTapped;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Card(
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey[100],
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter your message",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[300]!)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[300]!))),
                    controller: textEditingController,
                    focusNode: focusNode)),
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: SolhColors.primary_green,
              child: IconButton(
                  onPressed: () {
                    onSendBtnTapped(textEditingController.text);
                    textEditingController.clear();
                  },
                  color: Colors.white,
                  icon: const Icon(Icons.send)),
            )
          ],
        ),
      ),
    );
  }
}
