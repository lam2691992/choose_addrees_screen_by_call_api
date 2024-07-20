// choose_provinces.dart
import 'package:flutter/material.dart';
import 'package:chon_tinh/model/province_model.dart';
import 'package:chon_tinh/services/province_service.dart';

class ChooseProvinces extends StatefulWidget {
  final Function(String provinceId) onProvinceSelected;

  const ChooseProvinces({super.key, required this.onProvinceSelected});

  @override
  // ignore: library_private_types_in_public_api
  _ChooseProvincesState createState() => _ChooseProvincesState();
}

class _ChooseProvincesState extends State<ChooseProvinces> {
  String? _chooseProvinces;
  final ProvinceService _provinceService = ProvinceService();
  List<Data> _provinces = [];

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  void _loadProvinces() async {
    _provinces = await _provinceService.fetchProvinces();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          _provinceService.showProvinceModalBottomSheet(
            context,
            _provinces,
            (provinceId) {
              setState(() {
                _chooseProvinces = _provinces.firstWhere((p) => p.id == provinceId).name;
              });
              widget.onProvinceSelected(provinceId);
            },
          );
        },
        child: AbsorbPointer(
          child: TextField(
            controller: TextEditingController(text: _chooseProvinces),
            decoration: const InputDecoration(
              hintText: 'Thành phố/Tỉnh',
              hintStyle: TextStyle(fontWeight: FontWeight.w300),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              suffixIcon: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ),
    );
  }
}
