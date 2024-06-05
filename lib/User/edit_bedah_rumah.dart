import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditBedahRumahPage extends StatefulWidget {
  final Map<String, dynamic> bedahrumah;

  EditBedahRumahPage({required this.bedahrumah});

  @override
  _EditBedahRumahPageState createState() => _EditBedahRumahPageState();
}

class _EditBedahRumahPageState extends State<EditBedahRumahPage> {
  late TextEditingController _namaPemilikController;
  late TextEditingController _alamatController;
  late TextEditingController _fotoController;
  late TextEditingController _keteranganController;

  @override
  void initState() {
    super.initState();
    _namaPemilikController =
        TextEditingController(text: widget.bedahrumah['nama_pemilik']);
    _alamatController =
        TextEditingController(text: widget.bedahrumah['alamat']);
    _fotoController = TextEditingController(text: widget.bedahrumah['foto']);
    _keteranganController =
        TextEditingController(text: widget.bedahrumah['keterangan']);
  }

  Future<void> _updateBedahRumah() async {
    final response = await http.put(
      Uri.parse(
          "http://127.0.0.1:8000/api/bedahrumah/${widget.bedahrumah['id']}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nama_pemilik': _namaPemilikController.text,
        'alamat': _alamatController.text,
        'foto': _fotoController.text,
        'keterangan': _keteranganController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data successfully updated')),
      );
      Navigator.pop(context, "data-updated");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Request Bedah Rumah',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            TextFormField(
              controller: _namaPemilikController,
              decoration: InputDecoration(
                labelText: 'Nama Pemilik',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _fotoController,
              decoration: InputDecoration(
                labelText: 'Foto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _keteranganController,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _updateBedahRumah();
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}