import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tambah_anggota_page.dart';
import 'edit_anggota_page.dart';

class DataAnggotaPage extends StatefulWidget {
  const DataAnggotaPage({Key? key}) : super(key: key);

  @override
  State<DataAnggotaPage> createState() => _DataAnggotaPageState();
}

class _DataAnggotaPageState extends State<DataAnggotaPage> {
  late Future<List<dynamic>> _data;

  @override
  void initState() {
    _data = getData();
    super.initState();
  }

  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse("http://192.168.183.179:8000/api/anggota"));
    return jsonDecode(response.body);
  }

  Future<void> _refreshData() async {
    setState(() {
      _data = getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Anggota',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<dynamic>>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final list = snapshot.data!;
              if (list.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final anggota = list[index];
                    return Card(
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Depan: ${anggota['Nama_depan']}',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Text('Nama Belakang: ${anggota['Nama_belakang']}'),
                            SizedBox(height: 5.0),
                            Text('Gelar Depan: ${anggota['Gelar_depan']}'),
                            SizedBox(height: 5.0),
                            Text('Gelar Belakang: ${anggota['Gelar_belakang']}'),
                            SizedBox(height: 5.0),
                            Text('Tempat Lahir: ${anggota['Tempat_lahir']}'),
                            SizedBox(height: 5.0),
                            Text('Jenis Kelamin: ${anggota['Jenis_kelamin']}'),
                            SizedBox(height: 5.0),
                            Text('Golongan Darah: ${anggota['Golongan_darah']}'),
                            SizedBox(height: 5.0),
                            Text('Nomor Telepon: ${anggota['Nomor_telepon']}'),
                            SizedBox(height: 5.0),
                            Text('Foto: ${anggota['Foto']}'),
                            SizedBox(height: 5.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  String pop = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditAnggotaPage(anggota: anggota)),
                                  );

                                  if (pop == "data-updated") {
                                    _refreshData();
                                  }
                                },
                                child: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahAnggotaPage()),
          ).then((_) {
            _refreshData();
          });
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Icon(Icons.account_circle),
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
