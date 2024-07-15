import 'package:chon_tinh/widgets/chon_huyen.dart';
import 'package:chon_tinh/widgets/chon_tinh.dart';
import 'package:chon_tinh/widgets/chon_xa.dart';
import 'package:chon_tinh/widgets/dia_chi.dart';
import 'package:chon_tinh/widgets/email.dart';
import 'package:chon_tinh/widgets/so_dienthoai.dart';
import 'package:chon_tinh/widgets/tieptuc_button.dart';
import 'package:flutter/material.dart';
import 'package:chon_tinh/widgets/icons_row.dart';
import 'package:chon_tinh/widgets/ho_ten.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thanh toán',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: IconsRow(),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            HoTen(),
            SoDienthoai(),
            Email(),
            DiaChi(),
            ChonTinh(),
            ChonHuyen(),
            ChonXa(),
            TieptucButton()
          ],
        ),
      ),
    );
  }
}
