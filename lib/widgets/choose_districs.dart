import 'package:flutter/material.dart';

class ChonHuyen extends StatefulWidget {
  const ChonHuyen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChonHuyenState createState() => _ChonHuyenState();
}

class _ChonHuyenState extends State<ChonHuyen> {
  String? _selectedHuyen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Quận/huyện',
          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: DropdownButton<String>(
            value: _selectedHuyen,
            icon: const Icon(Icons.arrow_drop_down),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _selectedHuyen = newValue;
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
