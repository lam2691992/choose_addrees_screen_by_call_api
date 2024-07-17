import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:chon_tinh/model/distric_model.dart';

class ChooseDistrics extends StatefulWidget {
  final String provinceId;

  const ChooseDistrics(
      {super.key,
      required this.provinceId,
      required void Function(String districId) onDistricSelected});

  @override
  // ignore: library_private_types_in_public_api
  _ChooseDistricsState createState() => _ChooseDistricsState();

  void onDistricSelected(String s) {}
}

class _ChooseDistricsState extends State<ChooseDistrics> {
  String? _chooseDistric;
  List<Data2>? _dataList;
  final Dio _dio = Dio();
  late String apiUrl;

  @override
  void initState() {
    super.initState();
    _loadDataFromApi();
  }

  @override
  void didUpdateWidget(ChooseDistrics oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.provinceId != widget.provinceId) {
      _loadDataFromApi();
    }
  }

  void _loadDataFromApi() async {
    if (widget.provinceId.isEmpty) {
      setState(() {
        _dataList = [];
      });
      return;
    }
    try {
      apiUrl = 'https://esgoo.net/api-tinhthanh/2/${widget.provinceId}.htm';
      Response response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        DistricModel districModel = DistricModel.fromJson(response.data);
        setState(() {
          _dataList = districModel.data;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _dataList = [];
      });
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
                        'Quận/huyện',
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
            if (_dataList == null)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_dataList!.isEmpty)
              const Center(
                child: Text('Không có quận/huyện nào được tìm thấy.'),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _dataList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Data2 data = _dataList![index];
                    return ListTile(
                      title: Text(data.name ?? ''),
                      onTap: () {
                        widget.onDistricSelected(
                            data.id ?? ''); // Truyền id của huyện
                        setState(() {
                          _chooseDistric = data.name;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
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
            controller: TextEditingController(text: _chooseDistric),
            decoration: const InputDecoration(
              hintText: 'Quận/huyện',
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