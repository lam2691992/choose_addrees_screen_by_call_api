import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:chon_tinh/model/province_model.dart';

class ChooseProvinces extends StatefulWidget {
  final Function(String provinceId) onProvinceSelected;

  const ChooseProvinces({super.key, required this.onProvinceSelected});

  @override
  // ignore: library_private_types_in_public_api
  _ChooseProvincesState createState() => _ChooseProvincesState();

}

class _ChooseProvincesState extends State<ChooseProvinces> {
  String? _chooseProvinces;
  List<Data>? _dataList; // Danh sách dữ liệu từ API
  final Dio _dio = Dio(); // Khởi tạo một instance của Dio
  final String apiUrl = 'https://esgoo.net/api-tinhthanh/1/0.htm';

  @override
  void initState() {
    super.initState();
    _loadDataFromApi();
  }

  void _loadDataFromApi() async {
    try {
      Response response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        ProvinceModel provinceModel = ProvinceModel.fromJson(response.data);
       setState(() {
        _dataList = provinceModel.data?.map((data) => Data(
          id: data.id,
          name: data.name,
          nameEn: data.nameEn,
          fullName: data.fullName,
          fullNameEn: data.fullNameEn,
          latitude: data.latitude,
          longitude: data.longitude
        )).toList();
      });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 199, 220, 230),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tỉnh/thành phố',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            _dataList != null
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _dataList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Data data = _dataList![index];
                        return ListTile(
                          title: Text(data.name ?? ''),
                          onTap: () {
                            setState(() {
                              _chooseProvinces = data.name ?? '';
                            });
                            widget.onProvinceSelected(data.id.toString());
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => _showModalBottomSheet(context),
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
