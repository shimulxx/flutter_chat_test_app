import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key? key,
    required this.onTextChanged,
  }) : super(key: key);

  final Function(String) onTextChanged;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool isOnFocus = false;


  @override
  void didUpdateWidget(covariant SearchTextField oldWidget) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: widget.onTextChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: isOnFocus ? Colors.white : Colors.grey,),
          prefixIconConstraints: const BoxConstraints(minWidth: 45),
          hintText: 'Search',
          border: InputBorder.none,
          //hintStyle: TextStyle(color: kBlackColor.withOpacity(0.3)),
          focusedBorder:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 2, color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}