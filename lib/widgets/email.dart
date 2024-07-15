import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Text('Email', style: TextStyle(fontSize: 17),), 
              SizedBox(
                width: 3,
              ),
              Text(
                '*',
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Email của bạn',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ],
      ),
    );
  }
}
