import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahAnggotaPage extends StatefulWidget {
  @override
  _TambahAnggotaPageState createState() => _TambahAnggotaPageState();
}

class _TambahAnggotaPageState extends State<TambahAnggotaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaDepanController = TextEditingController();
  final TextEditingController _namaBelakangController = TextEditingController();
  final TextEditingController _gelarDepanController = TextEditingController();
  final TextEditingController _gelarBelakangController =
      TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _golonganDarahController =
      TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print('Form tidak valid');
      return;
    }

    final namaDepan = _namaDepanController.text;
    final namaBelakang = _namaBelakangController.text;
    final gelarDepan = _gelarDepanController.text;
    final gelarBelakang = _gelarBelakangController.text;
    final tempatLahir = _tempatLahirController.text;
    final jenisKelamin = _jenisKelaminController.text;
    final golonganDarah = _golonganDarahController.text;
    final nomorTelepon = _nomorTeleponController.text;
    final foto = _fotoController.text;

    print(
        'Mengirim data: Nama Depan: $namaDepan, Nama Belakang: $namaBelakang, Gelar Depan: $gelarDepan, Gelar Belakang: $gelarBelakang, Tempat Lahir: $tempatLahir, Jenis Kelamin: $jenisKelamin, Golongan Darah: $golonganDarah, Nomor Telepon: $nomorTelepon, Foto: $foto');

    try {
      final response = await http.post(
        Uri.parse('http://192.168.183.179:8000/api/tambahanggota'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Nama_depan': namaDepan,
          'Nama_belakang': namaBelakang,
          'Gelar_depan': gelarDepan,
          'Gelar_belakang': gelarBelakang,
          'Tempat_lahir': tempatLahir,
          'Jenis_kelamin': jenisKelamin,
          'Golongan_darah': golonganDarah,
          'Nomor_telepon': nomorTelepon,
          'Foto': foto,
        }),
      );

      print('Status respon: ${response.statusCode}');
      print('Isi respon: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Data berhasil ditambahkan');
        Navigator.pop(context, "data-added");
      } else {
        print('Gagal menambahkan data: ${response.body}');
        throw Exception('Gagal menambahkan data');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Tambah Data Anggota', style: TextStyle(color: Colors.white)),
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
                  controller: _namaDepanController,
                  decoration: InputDecoration(
                    labelText: 'Nama Depan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Depan';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _namaBelakangController,
                  decoration: InputDecoration(
                    labelText: 'Nama Belakang',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Belakang';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _gelarDepanController,
                  decoration: InputDecoration(
                    labelText: 'Gelar Depan',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _gelarBelakangController,
                  decoration: InputDecoration(
                    labelText: 'Gelar Belakang',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _tempatLahirController,
                  decoration: InputDecoration(
                    labelText: 'Tempat Lahir',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Tempat Lahir';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _jenisKelaminController,
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Jenis Kelamin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _golonganDarahController,
                  decoration: InputDecoration(
                    labelText: 'Golongan Darah',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Golongan Darah';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _nomorTeleponController,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nomor Telepon';
                    }
                    return null;
                  },
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitData(context);
                    } else {
                      print('Validasi formulir gagal');
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
