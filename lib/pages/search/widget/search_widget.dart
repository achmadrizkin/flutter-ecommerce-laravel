import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = subTitleTextStyle;
    final styleHint = subTitleTextStyle;
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: black),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: black),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: headingStyle.copyWith(color: grey),
          border: InputBorder.none,
        ),
        style: headingStyle2.copyWith(color: black, fontSize: 14),
        onChanged: widget.onChanged,
      ),
    );
  }
}
