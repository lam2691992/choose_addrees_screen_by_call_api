import 'package:chon_tinh/model/commune_model.dart'  ;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class ChooseCommunes extends StatefulWidget {
  final String provinceId;
  final String districId;

  const ChooseCommunes({super.key, required this.provinceId, required this.districId});

  @override
  // ignore: library_private_types_in_public_api
  _ChooseCommunesState createState() => _ChooseCommunesState();
}

class _ChooseCommunesState extends State<ChooseCommunes> {
  String? _chooseCommnune;
  List<Data3>? _dataList;
  final Dio _dio = Dio();
  late String apiUrl;

  @override
  void initState() {
    super.initState();
    _loadDataFromApi();
  }

  @override
  void didUpdateWidget(ChooseCommunes oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.districId != widget.districId) {
      _loadDataFromApi();
    }
  }

  void _loadDataFromApi() async {
    if (widget.districId.isEmpty) {
      setState(() {
        _dataList = [];
      });
      return;
    }
try {
  apiUrl = 'https://esgoo.net/api-tinhthanh/3/${widget.districId}.htm';
  Response response = await _dio.get(apiUrl);
  if (response.statusCode == 200) {
    print('Response data: ${response.data}');
    CommuneModel communeModel = CommuneModel.fromJson(response.data);
    setState(() {
      _dataList = communeModel.data;
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
                        'Xã/phường',
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
                child: Text('Không có Xã/phường nào được tìm thấy.'),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _dataList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Data3 data = _dataList![index];
                    return ListTile(
                      title: Text(data.name ?? ''),
                      onTap: () {
                        setState(() {
                          _chooseCommnune = data.name;
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
            controller: TextEditingController(text: _chooseCommnune),
            decoration: const InputDecoration(
              hintText: 'Xã/phường',
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
