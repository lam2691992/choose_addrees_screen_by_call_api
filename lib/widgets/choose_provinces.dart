import 'package:chon_tinh/model/province_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class ChonTinh extends StatefulWidget {
  const ChonTinh({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChonTinhState createState() => _ChonTinhState();
}

class _ChonTinhState extends State<ChonTinh> {
  String? _selectedTinh;
  List<Data>? _dataList; // Danh sách dữ liệu từ API
  final Dio _dio = Dio(); // Khởi tạo một instance của Dio
  final String apiUrl = 'https://esgoo.net/api-tinhthanh/4/0.htm';

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
          _dataList = provinceModel.data;
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
      builder: (BuildContext context) {
        return _dataList != null
            ? ListView.builder(
                itemCount: _dataList!.length,
                itemBuilder: (BuildContext context, int index) {
                  Data data = _dataList![index];
                  return ListTile(
                    title: Text(data.name ?? ''),
                    onTap: () {
                      setState(() {
                        _selectedTinh = data.name;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              )
            : const Center(child: CircularProgressIndicator());
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
            controller: TextEditingController(text: _selectedTinh),
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
