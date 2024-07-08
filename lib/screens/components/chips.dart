import 'package:flutter/material.dart';
import 'package:mebook/constants.dart';

class ChipsFilter extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  ChipsFilter({required this.categories, required this.onCategorySelected});

  @override
  _ChipsFilterState createState() => _ChipsFilterState();
}

class _ChipsFilterState extends State<ChipsFilter> {
  String _selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: widget.categories.map((category) {
          return ChoiceChip(
            label: Text(category),
            labelStyle: TextStyle(color: Color(0xff9d9686), fontSize: 17),
            selectedColor: Color(0xffe4e0cf),
            // backgroundColor: kBackgroundColor,
            selected: _selectedCategory == category,
            onSelected: (selected) {
              setState(() {
                _selectedCategory = selected ? category : "";
                widget.onCategorySelected(_selectedCategory);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
