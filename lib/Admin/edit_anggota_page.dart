import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditAnggotaPage extends StatefulWidget {
  final Map<String, dynamic> anggota;

  EditAnggotaPage({required this.anggota});

  @override
  _EditAnggotaPageState createState() => _EditAnggotaPageState();
}

class _EditAnggotaPageState extends State<EditAnggotaPage> {
  final TextEditingController namaDepanController = TextEditingController();
  final TextEditingController namaBelakangController = TextEditingController();
  final TextEditingController gelarDepanController = TextEditingController();
  final TextEditingController gelarBelakangController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController golonganDarahController = TextEditingController();
  final TextEditingController nomorTeleponController = TextEditingController();
  final TextEditingController fotoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    namaDepanController.text = widget.anggota['Nama_depan'] ?? '';
    namaBelakangController.text = widget.anggota['Nama_belakang'] ?? '';
    gelarDepanController.text = widget.anggota['Gelar_depan'] ?? '';
    gelarBelakangController.text = widget.anggota['Gelar_belakang'] ?? '';
    tempatLahirController.text = widget.anggota['Tempat_lahir'] ?? '';
    jenisKelaminController.text = widget.anggota['Jenis_kelamin'] ?? '';
    golonganDarahController.text = widget.anggota['Golongan_darah'] ?? '';
    nomorTeleponController.text = widget.anggota['Nomor_telepon'] ?? '';
    fotoController.text = widget.anggota['Foto'] ?? '';
  }

  Future<void> updateAnggota() async {
    try {
      final response = await http.put(
        Uri.parse(
            "http://192.168.183.179:8000/api/anggota/${widget.anggota['Id_anggota']}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "Nama_depan": namaDepanController.text,
          "Nama_belakang": namaBelakangController.text,
          "Gelar_depan": gelarDepanController.text,
          "Gelar_belakang": gelarBelakangController.text,
          "Tempat_lahir": tempatLahirController.text,
          "Jenis_kelamin": jenisKelaminController.text,
          "Golongan_darah": golonganDarahController.text,
          "Nomor_telepon": nomorTeleponController.text,
          "Foto": fotoController.text,
          "Id_status": widget.anggota['Id_status'],
          "Id_hubungan_keluarga": widget.anggota['Id_hubungan_keluarga'],
          "Id_pekerjaan": widget.anggota['Id_pekerjaan'],
          "Id_pendidikan": widget.anggota['Id_pendidikan'],
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data berhasil diperbarui')));
        Navigator.pop(context, "data-updated");
      } else {
        print('Failed to update anggota: ${response.body}');
        throw Exception('Failed to update anggota: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Anggota', style: TextStyle(color: Colors.white)),
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
                      controller: namaDepanController,
                      decoration: InputDecoration(
                        labelText: 'Nama Depan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: namaBelakangController,
                      decoration: InputDecoration(
                        labelText: 'Nama Belakang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: gelarDepanController,
                      decoration: InputDecoration(
                        labelText: 'Gelar Depan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: gelarBelakangController,
                      decoration: InputDecoration(
                        labelText: 'Gelar Belakang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: tempatLahirController,
                      decoration: InputDecoration(
                        labelText: 'Tempat Lahir',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: jenisKelaminController,
                      decoration: InputDecoration(
                        labelText: 'Jenis Kelamin',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: golonganDarahController,
                      decoration: InputDecoration(
                        labelText: 'Golongan Darah',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: nomorTeleponController,
                      decoration: InputDecoration(
                        labelText: 'Nomor Telepon',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: fotoController,
                      decoration: InputDecoration(
                        labelText: 'Foto',
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
              updateAnggota();
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
                  "Edit Data",
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
