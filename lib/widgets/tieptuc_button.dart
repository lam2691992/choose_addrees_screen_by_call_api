import 'package:flutter/material.dart';


class TieptucButton extends StatelessWidget{
  const TieptucButton({super.key});
  
  @override
  Widget build(BuildContext context) {
   return TextButton(onPressed: () {
    print('Tiếp tục');
   },
   style: const ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.black),
    backgroundColor: WidgetStatePropertyAll(Colors.grey),
    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 170.0,))
    ),
    child: const Text('Tiếp tục'),);
  }
  

  
}