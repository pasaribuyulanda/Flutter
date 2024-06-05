import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'beasiswa.dart';

class TambahBeasiswaPage extends StatefulWidget {
  @override
  _TambahBeasiswaPageState createState() => _TambahBeasiswaPageState();
}

class _TambahBeasiswaPageState extends State<TambahBeasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  File? _selectedImage;
  Uint8List? _webImage;

  Future<void> _chooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        _webImage = await pickedFile.readAsBytes();
        setState(() {});
      } else {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> _submitData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print('Form tidak valid');
      return;
    }

    final nama = _namaController.text;
    final alamat = _alamatController.text;
    final keterangan = _keteranganController.text;

    print(
        'Mengirim data: nama: $nama, alamat: $alamat, keterangan: $keterangan, foto: $_selectedImage');

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/api/tambahbeasiswa'),
      );

      request.fields['nama'] = nama;
      request.fields['alamat'] = alamat;
      request.fields['keterangan'] = keterangan;

      if (_selectedImage != null) {
        var foto = await http.MultipartFile.fromPath(
            'foto_nilai_rapor', _selectedImage!.path);
        request.files.add(foto);
      } else if (_webImage != null) {
        var foto = http.MultipartFile.fromBytes('foto_nilai_rapor', _webImage!,
            filename: 'upload.png');
        request.files.add(foto);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Status respon: ${response.statusCode}');
      print('Isi respon: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Data berhasil ditambahkan');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BeasiswaPage()),
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
        title: Text(
          'Tambah Data Request Beasiswa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Pemilik tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _keteranganController,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Keterangan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _chooseImage,
                    child: Text('Pilih Gambar',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shadowColor: Colors.black,
                      elevation: 8,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  if (kIsWeb)
                    _webImage != null
                        ? Image.memory(
                            _webImage!,
                            width: 100,
                            height: 100,
                          )
                        : Text('Tidak ada gambar yang dipilih')
                  else
                    _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            width: 100,
                            height: 100,
                          )
                        : Text('Tidak ada gambar yang dipilih'),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Form valid, mengirim...');
                    _submitData(context);
                  }
                },
                child: Text('Submit', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Warna tombol submit biru
                  shadowColor: Colors.black, // Warna bayangan tombol
                  elevation: 8, // Tinggi bayangan tombol
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
