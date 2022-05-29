import 'package:flutter/material.dart';

import '../../colors/color.dart';

const List<String> dropDownMenus = ['신상품순', '판매량순', "혜택순", "낮은 가격순", "높은 가격순"];

class ProductDropDownWidget extends StatefulWidget {
  const ProductDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ProductDropDownWidget> createState() => _ProductDropDownWidgetState();
}

class _ProductDropDownWidgetState extends State<ProductDropDownWidget> {
  String dropdownValue = dropDownMenus[0];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      elevation: 16,
      style: TextStyle(fontSize: width * 0.025, color: blackColor),
      underline: const SizedBox(),
      // ignore: non_constant_identifier_names
      onChanged: (String? NewValue) {
        setState(() {
          dropdownValue = NewValue!;
        });
      },
      items: dropDownMenus.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
