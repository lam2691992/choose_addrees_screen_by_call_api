
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:chon_tinh/model/province_model.dart';

class ProvinceService {
  final Dio _dio = Dio();
  final String apiUrl = 'https://esgoo.net/api-tinhthanh/1/0.htm';

  Future<List<Data>> fetchProvinces() async {
    try {
      Response response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        ProvinceModel provinceModel = ProvinceModel.fromJson(response.data);
        return provinceModel.data ?? [];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error loading data: $e');
      return [];
    }
  }

  void showProvinceModalBottomSheet(
    BuildContext context,
    List<Data> provinces,
    Function(String) onProvinceSelected,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            String searchQuery = '';

            List<Data> filteredProvinces = provinces.where((province) {
              return province.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
            }).toList();

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    autofocus: true,  // Tự động focus khi mở modal
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Tìm kiếm tỉnh/thành phố',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        filteredProvinces = provinces.where((province) {
                          return province.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
                        }).toList();
                      });
                    },
                  ),
                ),
                filteredProvinces.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: filteredProvinces.length,
                          itemBuilder: (BuildContext context, int index) {
                            Data data = filteredProvinces[index];
                            return ListTile(
                              title: Text(data.name ?? ''),
                              onTap: () {
                                onProvinceSelected(data.id ?? '');
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      )
                    : const Center(child: Text('Không có kết quả')),
              ],
            );
          },
        );
      },
    );
  }
}
