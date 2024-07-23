// choose_provinces.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chon_tinh/services/province_service.dart';
import 'province_bloc.dart';

class ChooseProvinces extends StatelessWidget {
  final Function(String provinceId) onProvinceSelected;

  const ChooseProvinces({super.key, required this.onProvinceSelected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProvinceBloc(ProvinceService())..add(LoadProvinces()),
      child: ChooseProvincesContent(onProvinceSelected: onProvinceSelected),
    );
  }
}

class ChooseProvincesContent extends StatelessWidget {
  final Function(String provinceId) onProvinceSelected;

  const ChooseProvincesContent({super.key, required this.onProvinceSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          final state = context.read<ProvinceBloc>().state;
          if (state is ProvinceLoaded) {
            ProvinceService().showProvinceModalBottomSheet(
              context,
              state.provinces,
              (provinceId) {
                context.read<ProvinceBloc>().add(SelectProvince(provinceId));
                onProvinceSelected(provinceId);
              },
            );
          }
        },
        child: AbsorbPointer(
          child: BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              String? selectedProvinceName;
              if (state is ProvinceSelected) {
                selectedProvinceName = state.provinceName;
              }
              return TextField(
                controller: TextEditingController(text: selectedProvinceName),
                decoration: const InputDecoration(
                  hintText: 'Thành phố/Tỉnh',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
