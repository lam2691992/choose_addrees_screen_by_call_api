import 'package:flutter/material.dart';

class IconsRow extends StatelessWidget {
  const IconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  const Column(
                    children: [
                      Icon(
                        Icons.directions_car,
                        size: 30,
                      ),
                      Text(
                        'Vận chuyển',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 2,
                    color: Colors.black,
                  ),
                  const Column(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        size: 30,
                      ),
                      Text('Thanh toán')
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 1,
                    color: Colors.grey,
                  ),
                  const Column(
                    children: [
                      Icon(
                        Icons.check_box_sharp,
                        size: 30,
                      ),
                      Text('Xác nhận')
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
    
  }
}
