import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditRegionalPage extends StatefulWidget {
  final Map<String, dynamic> regional;

  EditRegionalPage({required this.regional});

  @override
  _EditRegionalPageState createState() => _EditRegionalPageState();
}

class _EditRegionalPageState extends State<EditRegionalPage> {
  final TextEditingController kodeRegionalController = TextEditingController();
  final TextEditingController namaRegionalController = TextEditingController();
  final TextEditingController alamatRegionalController =
      TextEditingController();
  final TextEditingController namaKepalaRegionalController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    kodeRegionalController.text = widget.regional['Kode_regional'];
    namaRegionalController.text = widget.regional['Nama_regional'];
    alamatRegionalController.text = widget.regional['Alamat_regional'];
    namaKepalaRegionalController.text = widget.regional['Nama_kepala_regional'];
  }

  Future<void> updateRegional() async {
    final response = await http.put(
      Uri.parse(
          "http://172.27.81.66:8000/api/regional/${widget.regional['Id_regional']}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "Kode_regional": kodeRegionalController.text,
        "Nama_regional": namaRegionalController.text,
        "Alamat_regional": alamatRegionalController.text,
        "Nama_kepala_regional": namaKepalaRegionalController.text,
        "Id_pusat": widget.regional['Id_pusat'],
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data berhasil diperbarui')));
      // Refresh data after update
      setState(() {
        widget.regional['Kode_regional'] = kodeRegionalController.text;
        widget.regional['Nama_regional'] = namaRegionalController.text;
        widget.regional['Alamat_regional'] = alamatRegionalController.text;
        widget.regional['Nama_kepala_regional'] =
            namaKepalaRegionalController.text;
      });
      Navigator.pop(context, "data-updated");
    } else {
      print('Failed to update regional: ${response.body}');
      throw Exception('Failed to update regional: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Regional',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: kodeRegionalController,
                    decoration: InputDecoration(
                      labelText: 'Kode Regional',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: namaRegionalController,
                    decoration: InputDecoration(
                      labelText: 'Nama Regional',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: alamatRegionalController,
                    decoration: InputDecoration(
                      labelText: 'Alamat Regional',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: namaKepalaRegionalController,
                    decoration: InputDecoration(
                      labelText: 'Nama Kepala Regional',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              updateRegional();
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Edit data",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
