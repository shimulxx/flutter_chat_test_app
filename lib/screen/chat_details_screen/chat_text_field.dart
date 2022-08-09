import 'package:flutter/material.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    Key? key,
    required this.onTextSend,
  }) : super(key: key);

  final Function(String) onTextSend;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool isOnFocus = false;

  @override
  void didUpdateWidget(covariant ChatTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() { isOnFocus = focusNode.hasFocus; });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                focusNode: focusNode,
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.message, color: isOnFocus ? Colors.white : Colors.grey,),
                  prefixIconConstraints: const BoxConstraints(minWidth: 45),
                  hintText: 'Type here',
                  border: InputBorder.none,
                  //hintStyle: TextStyle(color: kBlackColor.withOpacity(0.3)),
                  focusedBorder:  const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                widget.onTextSend(controller.text);
                controller.clear();
              },
              child: const AbsorbPointer(
                child: SizedBox(
                  width: 50,
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}