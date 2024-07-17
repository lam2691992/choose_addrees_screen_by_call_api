import 'package:flutter/material.dart';

class FullName extends StatelessWidget {
  const FullName({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Họ và tên',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                width: 3,
              ),
              Text('*', style: TextStyle(color: Colors.red)),
            ],
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Tên của bạn',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ],
      ),
    );
  }
}
