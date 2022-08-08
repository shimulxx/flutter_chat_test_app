import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../data_model/drop_down_data.dart';


class AppDropDownMenu extends StatefulWidget {
  const AppDropDownMenu({
    Key? key,
    required this.items,
    required this.onChangeValue,
  }) : super(key: key);

  final List<AlertDialogDropDownData> items;
  final Function(String) onChangeValue;

  @override
  State<AppDropDownMenu> createState() => _AppDropDownMenuState();
}

class _AppDropDownMenuState extends State<AppDropDownMenu> {
  late var selectedValue = widget.items.isEmpty ? AlertDialogDropDownData.empty() : widget.items[0];
  //var selectedValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<AlertDialogDropDownData>(
      underline: const SizedBox(),
      value: selectedValue,
        items: widget.items.map<DropdownMenuItem<AlertDialogDropDownData>>((e) {
          return DropdownMenuItem(
            value: e,
            child: Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: e.imageUrl,
                    height: 35,
                    width: 35,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.name, style: const TextStyle(fontSize: 18),),
                    const SizedBox(height: 2,),
                    Text(e.email, style: const TextStyle(fontSize: 13),)
                  ],
                )
              ],
            ),
          );
        }).toList(),
        onChanged: (v){
          setState(() {
            selectedValue = v!;
            widget.onChangeValue(v.id);
          });
        },
    );
  }
}
