import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditBeasiswaPage extends StatefulWidget {
  final Map<String, dynamic> beasiswa;

  EditBeasiswaPage({required this.beasiswa});

  @override
  _EditBeasiswaPageState createState() => _EditBeasiswaPageState();
}

class _EditBeasiswaPageState extends State<EditBeasiswaPage> {
  late TextEditingController _namaController;
  late TextEditingController _alamatController;
  late TextEditingController _keteranganController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.beasiswa['nama']);
    _alamatController = TextEditingController(text: widget.beasiswa['alamat']);
    _keteranganController =
        TextEditingController(text: widget.beasiswa['keterangan']);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  Future<void> _updateBeasiswa() async {
    try {
      String imageUrl = widget.beasiswa['foto_nilai_rapor'];

      if (_selectedImage != null) {
        final response = await http.post(
          Uri.parse("http://127.0.0.1:8000/api/upload-image"),
          body: {
            'image': base64Encode(_selectedImage!.readAsBytesSync()),
          },
        );

        if (response.statusCode == 200) {
          imageUrl = response.body;
        } else {
          throw Exception('Failed to upload image');
        }
      }

      final response = await http.put(
        Uri.parse(
            "http://127.0.0.1:8000/api/beasiswa/${widget.beasiswa['id']}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'nama': _namaController.text,
          'alamat': _alamatController.text,
          'keterangan': _keteranganController.text,
          'foto_nilai_rapor': imageUrl,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data successfully updated')),
        );
        Navigator.pop(context, "data-updated");
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Request Beasiswa',
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
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
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
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    'http://127.0.0.1:8000/images/${widget.beasiswa['foto_nilai_rapor']}',
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Pick Image'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Changed to match the theme color
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
              onPressed: _updateBeasiswa,
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Changed to match the theme color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
