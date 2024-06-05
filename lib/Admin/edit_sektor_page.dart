import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditSektorPage extends StatefulWidget {
  final Map<String, dynamic> sektor;

  EditSektorPage({required this.sektor});

  @override
  _EditSektorPageState createState() => _EditSektorPageState();
}

class _EditSektorPageState extends State<EditSektorPage> {
  final TextEditingController kodeSektorController = TextEditingController();
  final TextEditingController namaSektorController = TextEditingController();
  final TextEditingController alamatSektorController = TextEditingController();
  final TextEditingController namaKepalaSektorController =
      TextEditingController();
  final TextEditingController tanggalberdiriController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    kodeSektorController.text = widget.sektor['Kode_sektor'] ?? '';
    namaSektorController.text = widget.sektor['Nama_sektor'] ?? '';
    alamatSektorController.text = widget.sektor['Alamat_sektor'] ?? '';
    namaKepalaSektorController.text = widget.sektor['Nama_kepala_sektor'] ?? '';
    tanggalberdiriController.text = widget.sektor['Tanggal_berdiri'] ?? '';
  }

  Future<void> updateSektor() async {
    try {
      final response = await http.put(
        Uri.parse(
            "http://172.27.81.66:8000/api/sektor/${widget.sektor['Id_sektor']}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "Kode_sektor": kodeSektorController.text,
          "Nama_sektor": namaSektorController.text,
          "Alamat_sektor": alamatSektorController.text,
          "Nama_kepala_sektor": namaKepalaSektorController.text,
          "Tanggal_berdiri": tanggalberdiriController.text,
          "Id_cabang": widget.sektor['Id_cabang'],
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data berhasil diperbarui')));
        Navigator.pop(context, "data-updated");
      } else {
        print('Failed to update cabang: ${response.body}');
        throw Exception('Failed to update cabang: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Sektor', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 182, 34, 24),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: kodeSektorController,
                      decoration: InputDecoration(
                        labelText: 'Kode Sektor',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: namaSektorController,
                      decoration: InputDecoration(
                        labelText: 'Nama Sektor',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: alamatSektorController,
                      decoration: InputDecoration(
                        labelText: 'Alamat Sektor',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: namaKepalaSektorController,
                      decoration: InputDecoration(
                        labelText: 'Nama Kepala Sektor',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: tanggalberdiriController,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Berdiri',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              updateSektor();
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
