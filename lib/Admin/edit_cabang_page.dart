import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditCabangPage extends StatefulWidget {
  final Map<String, dynamic> cabang;

  EditCabangPage({required this.cabang});

  @override
  _EditCabangPageState createState() => _EditCabangPageState();
}

class _EditCabangPageState extends State<EditCabangPage> {
  final TextEditingController kodeCabangController = TextEditingController();
  final TextEditingController namaCabangController = TextEditingController();
  final TextEditingController alamatCabangController = TextEditingController();
  final TextEditingController namaKepalaCabangController =
      TextEditingController();
  final TextEditingController tanggalberdiriController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    kodeCabangController.text = widget.cabang['Kode_cabang'] ?? '';
    namaCabangController.text = widget.cabang['Nama_cabang'] ?? '';
    alamatCabangController.text = widget.cabang['Alamat_cabang'] ?? '';
    namaKepalaCabangController.text = widget.cabang['Nama_kepala_cabang'] ?? '';
    tanggalberdiriController.text = widget.cabang['Tanggal_berdiri'] ?? '';
  }

  Future<void> updateCabang() async {
    try {
      final response = await http.put(
        Uri.parse(
            "http://172.27.81.66:8000/api/cabang/${widget.cabang['Id_cabang']}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "Kode_cabang": kodeCabangController.text,
          "Nama_cabang": namaCabangController.text,
          "Alamat_cabang": alamatCabangController.text,
          "Nama_kepala_cabang": namaKepalaCabangController.text,
          "Tanggal_berdiri": tanggalberdiriController.text,
          "Id_regional": widget.cabang['Id_regional'],
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
        title: Text('Edit Data Cabang', style: TextStyle(color: Colors.white)),
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
                      controller: kodeCabangController,
                      decoration: InputDecoration(
                        labelText: 'Kode Cabang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: namaCabangController,
                      decoration: InputDecoration(
                        labelText: 'Nama Cabang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: alamatCabangController,
                      decoration: InputDecoration(
                        labelText: 'Alamat Cabang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: namaKepalaCabangController,
                      decoration: InputDecoration(
                        labelText: 'Nama Kepala Cabang',
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
              updateCabang();
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
