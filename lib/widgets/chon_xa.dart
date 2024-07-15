import 'package:flutter/material.dart';

class ChonXa extends StatefulWidget {
  const ChonXa({super.key});

  @override
  _ChonXaState createState() => _ChonXaState();
}

class _ChonXaState extends State<ChonXa> {
  String? _selectedXa;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Phường/xã',
          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: DropdownButton<String>(
            value: _selectedXa,
            icon: const Icon(Icons.arrow_drop_down),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _selectedXa = newValue;
              });
            },
            items:
                <String>[''].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
