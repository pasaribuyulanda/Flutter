import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPusatPage extends StatefulWidget {
  final Map<String, dynamic> pusat;

  EditPusatPage({required this.pusat});

  @override
  _EditPusatPageState createState() => _EditPusatPageState();
}

class _EditPusatPageState extends State<EditPusatPage> {
  final TextEditingController kodePusatController = TextEditingController();
  final TextEditingController namaPusatController = TextEditingController();
  final TextEditingController alamatPusatController = TextEditingController();
  final TextEditingController namaKepalaPusatController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    kodePusatController.text = widget.pusat['Kode_pusat'];
    namaPusatController.text = widget.pusat['Nama_pusat'];
    alamatPusatController.text = widget.pusat['Alamat_pusat'];
    namaKepalaPusatController.text = widget.pusat['Nama_kepala_pusat'];
  }

  Future<void> updateRegional() async {
    final response = await http.put(
      Uri.parse("http://127.0.0.1:8000/api/pusat/${widget.pusat['Id_pusat']}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "Kode_pusat": kodePusatController.text,
        "Nama_pusat": namaPusatController.text,
        "Alamat_pusat": alamatPusatController.text,
        "Nama_kepala_pusat": namaKepalaPusatController.text,
        "Id_pusat": widget.pusat['Id_pusat'],
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data berhasil diperbarui')));
      // Refresh data after update
      setState(() {
        widget.pusat['Kode_pusat'] = kodePusatController.text;
        widget.pusat['Nama_pusat'] = namaPusatController.text;
        widget.pusat['Alamat_pusat'] = alamatPusatController.text;
        widget.pusat['Nama_kepala_pusat'] = namaKepalaPusatController.text;
      });
      Navigator.pop(context, "data-updated");
    } else {
      print('Failed to update pusat: ${response.body}');
      throw Exception('Failed to update pusat: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Pusat',
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
                    controller: kodePusatController,
                    decoration: InputDecoration(
                      labelText: 'Kode Pusat',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: namaPusatController,
                    decoration: InputDecoration(
                      labelText: 'Nama Pusat',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: alamatPusatController,
                    decoration: InputDecoration(
                      labelText: 'Alamat Pusat',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: namaKepalaPusatController,
                    decoration: InputDecoration(
                      labelText: 'Nama Kepala Pusat',
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
