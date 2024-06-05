import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'datasektor_page.dart';

class TambahSektorPage extends StatefulWidget {
  @override
  _TambahSektorPageState createState() => _TambahSektorPageState();
}

class _TambahSektorPageState extends State<TambahSektorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kepalaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  String? _selectedCabang;
  List<Map<String, dynamic>> cabang = [];

  @override
  void initState() {
    super.initState();
    _fetchPusatOptions();
  }

  Future<void> _fetchPusatOptions() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.183.179:8000/api/cabang'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          cabang = data.map((item) {
            return {
              'Id_cabang': item['Id_cabang'],
              'Nama_cabang': item['Nama_cabang']
            };
          }).toList();
        });
      } else {
        print('Gagal mengambil opsi cabang: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengambil opsi cabang: $e');
    }
  }

  Future<void> _submitData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print('Form tidak valid');
      return;
    }

    final kode = _kodeController.text;
    final nama = _namaController.text;
    final alamat = _alamatController.text;
    final kepala = _kepalaController.text;
    final tanggal = _tanggalController.text;

    print(
        'Mengirim data: Kode_regional: $kode, Nama_regional: $nama, Alamat_regional: $alamat, Nama_kepala_regional: $kepala, Tanggal_berdiri: $tanggal, Id_cabang: $_selectedCabang');

    try {
      final response = await http.post(
        Uri.parse('http://172.27.81.66:8000/api/tambahsektor'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Kode_sektor': kode,
          'Nama_sektor': nama,
          'Alamat_sektor': alamat,
          'Nama_kepala_sektor': kepala,
          'Tanggal_berdiri': tanggal,
          'Id_cabang': _selectedCabang!,
        }),
      );

      print('Status respon: ${response.statusCode}');
      print('Isi respon: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Data berhasil ditambahkan');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DataSektorPage()),
        );
      } else {
        print('Gagal menambahkan data: ${response.body}');
        throw Exception('Gagal menambahkan data');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _tanggalController.text = "${pickedDate.toLocal()}"
            .split(' ')[0]; // Set the date format as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Tambah Data Sektor', style: TextStyle(color: Colors.white)),
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
                    labelText: 'Kode Sektor',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Kode Sektor';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Sektor',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Sektor';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat Sektor',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Alamat Sektor';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _kepalaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Kepala Sektor',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Kepala Sektor';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _tanggalController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Berdiri',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Tanggal Berdiri';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedCabang,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCabang = newValue!;
                    });
                  },
                  items: cabang.map<DropdownMenuItem<String>>(
                      (Map<String, dynamic> pusat) {
                    return DropdownMenuItem<String>(
                      value: pusat['Id_cabang'].toString(),
                      child: Text(pusat['Nama_cabang']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Cabang',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih Cabang';
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
