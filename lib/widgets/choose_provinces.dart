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

class ChooseProvincesContent extends StatefulWidget {
  final Function(String provinceId) onProvinceSelected;

  const ChooseProvincesContent({super.key, required this.onProvinceSelected});

  @override
  State<ChooseProvincesContent> createState() => _ChooseProvincesContentState();
}

class _ChooseProvincesContentState extends State<ChooseProvincesContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          final bloc = context.read<ProvinceBloc>();
          final state = bloc.state;

          if (state is ProvinceSelected) {
            bloc.add(ShowProvinceList());
            // gửi ShowProvinceList, kiểm tra lại trạng thái và hiển thị danh sách tỉnh
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final newState = bloc.state;
              if (newState is ProvinceLoaded) {
                ProvinceService().showProvinceModalBottomSheet(
                  context,
                  newState.provinces,
                  (provinceId) {
                    bloc.add(SelectProvince(provinceId));
                    widget.onProvinceSelected(provinceId);
                  },
                );
              }
            });
          } else if (state is ProvinceLoaded) {
            ProvinceService().showProvinceModalBottomSheet(
              context,
              state.provinces,
              (provinceId) {
                bloc.add(SelectProvince(provinceId));
                widget.onProvinceSelected(provinceId);
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
              return AnimatedSwitcher( duration: Duration(microseconds: 500),
                child: TextField(
                  controller: TextEditingController(text: selectedProvinceName),
                  decoration: const InputDecoration(
                    hintText: 'Thành phố/Tỉnh',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
