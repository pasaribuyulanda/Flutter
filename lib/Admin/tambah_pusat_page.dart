import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'datapusat_page.dart';

class TambahPusatPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kepalaController = TextEditingController();

  Future<void> _submitData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print('Form is not valid');
      return;
    }

    final kode = _kodeController.text;
    final nama = _namaController.text;
    final alamat = _alamatController.text;
    final kepala = _kepalaController.text;

    print(
        'Submitting data: Kode: $kode, Nama: $nama, Alamat: $alamat, Kepala: $kepala');

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/tambahpusat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'kode_pusat': kode,
          'nama_pusat': nama,
          'alamat_pusat': alamat,
          'nama_kepala_pusat': kepala,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Data successfully added');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DataPusatPage()),
        );
      } else {
        print('Failed to add data: ${response.body}');
        throw Exception('Failed to add data');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Pusat', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 182, 34, 24),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _kodeController,
                  decoration: InputDecoration(
                    labelText: 'Kode Pusat',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Kode Regional';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Pusat',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Nama Pusat';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat Pusat',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Alamat Pusat';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _kepalaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Kepala Pusat',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Nama Kepala Pusat';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _submitData(context);
                    } else {
                      print('Form validation failed');
                    }
                  },
                  child: Text('Submit', style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
