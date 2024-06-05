import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dataregional_page.dart';

class TambahRegionalPage extends StatefulWidget {
  @override
  _TambahRegionalPageState createState() => _TambahRegionalPageState();
}

class _TambahRegionalPageState extends State<TambahRegionalPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kepalaController = TextEditingController();
  String? _selectedPusat; // State untuk menyimpan pusat yang dipilih
  List<Map<String, dynamic>> pusatOptions =
      []; // List untuk menyimpan Id dan Nama pusat

  @override
  void initState() {
    super.initState();
    _fetchPusatOptions();
  }

  Future<void> _fetchPusatOptions() async {
    try {
      final response =
          await http.get(Uri.parse('http://172.27.81.66:8000/api/pusat'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          pusatOptions = data.map((item) {
            return {
              'Id_pusat': item['Id_pusat'],
              'Nama_pusat': item['Nama_pusat']
            };
          }).toList();
        });
      } else {
        print('Gagal mengambil opsi pusat: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengambil opsi pusat: $e');
    }
  }

  // Fungsi untuk mengirim data ke backend saat tombol Submit ditekan
  Future<void> _submitData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print('Form tidak valid');
      return;
    }

    final kode = _kodeController.text;
    final nama = _namaController.text;
    final alamat = _alamatController.text;
    final kepala = _kepalaController.text;

    print(
        'Mengirim data: Kode_regional: $kode, Nama_regional: $nama, Alamat_regional: $alamat, Nama_kepala_regional: $kepala, Id_pusat: $_selectedPusat');

    try {
      final response = await http.post(
        Uri.parse('http://192.168.183.179:8000/api/tambahregional'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Kode_regional': kode,
          'Nama_regional': nama,
          'Alamat_regional': alamat,
          'Nama_kepala_regional': kepala,
          'Id_pusat': _selectedPusat!,
        }),
      );

      print('Status respon: ${response.statusCode}');
      print('Isi respon: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Data berhasil ditambahkan');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DataRegionalPage()),
        );
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
            Text('Tambah Data Regional', style: TextStyle(color: Colors.white)),
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
                    labelText: 'Kode Regional',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Kode Regional';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Regional',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Regional';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat Regional',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Alamat Regional';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _kepalaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Kepala Regional',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Kepala Regional';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedPusat,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPusat = newValue!;
                    });
                  },
                  items: pusatOptions.map<DropdownMenuItem<String>>(
                      (Map<String, dynamic> pusat) {
                    return DropdownMenuItem<String>(
                      value: pusat['Id_pusat'].toString(),
                      child: Text(pusat['Nama_pusat']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Pusat',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih Pusat';
                    }
                    return null;
                  },
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
