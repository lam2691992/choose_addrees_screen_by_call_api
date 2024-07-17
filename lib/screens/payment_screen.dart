import 'package:flutter/material.dart';
import 'package:chon_tinh/widgets/choose_districs.dart';
import 'package:chon_tinh/widgets/choose_provinces.dart';
import 'package:chon_tinh/widgets/choose_communes.dart';
import 'package:chon_tinh/widgets/address.dart';
import 'package:chon_tinh/widgets/email.dart';
import 'package:chon_tinh/widgets/phone_number.dart';
import 'package:chon_tinh/widgets/next_button.dart';
import 'package:chon_tinh/widgets/icons_row.dart';
import 'package:chon_tinh/widgets/fullname.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedProvinceId;
  String? _selectedDistrictId;

  void _onProvinceSelected(String provinceId) {
    setState(() {
      _selectedProvinceId = provinceId;
      _selectedDistrictId = null;
    });
  }

  void _onDistrictSelected(String districtId) {
    setState(() {
      _selectedDistrictId = districtId; // Cập nhật giá trị quận/huyện khi chọn
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: IconsRow(),
              ),
            ),
            const SizedBox(
              height: 11,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: FullName(),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: PhoneNumber(),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Email(),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Address(),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ChooseProvinces(
                onProvinceSelected: _onProvinceSelected,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ChooseDistrics(
                provinceId: _selectedProvinceId ?? '',
                onDistricSelected: (String districId) {},
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12),
  child: ChooseCommunes(
    provinceId: _selectedProvinceId ?? '',
    districId: _selectedDistrictId ?? '',
  ),
),

            const SizedBox(
              height: 12,
            ),
            const NextButton(),
          ],
        ),
      ),
    );
  }
}