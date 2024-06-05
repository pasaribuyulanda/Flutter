import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrasiAnggotaPage extends StatefulWidget {
  @override
  _RegistrasiAnggotaPageState createState() =>
      _RegistrasiAnggotaPageState();
}

class _RegistrasiAnggotaPageState
    extends State<RegistrasiAnggotaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      final String nama = _namaController.text;
      final String alamat = _alamatController.text;
      final String nik = _nikController.text;
      final String noTelp = _noTelpController.text;
      final String pekerjaan = _pekerjaanController.text;

      try {
        final response = await http.post(
          Uri.parse('http://192.168.183.179:8000/api/registrasi_anggota'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'Nama': nama,
            'Alamat': alamat,
            'NIK': nik,
            'No_telp': noTelp,
            'Pekerjaan': pekerjaan,
          }),
        );

        if (response.statusCode == 201) {
          // Handle success
          Navigator.pop(context, 'data-added');
        } else {
          // Handle errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add data: ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Registrasi Anggota'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Nama';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _alamatController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Alamat';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _nikController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter NIK';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'NIK'),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _noTelpController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Nomor Telepon';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _pekerjaanController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Pekerjaan';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Pekerjaan'),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitData,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
