import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'edit_bedah_rumah.dart';
import 'tambah_bedah_rumah.dart';

class BedahRumahPage extends StatefulWidget {
  const BedahRumahPage({Key? key}) : super(key: key);

  @override
  _BedahRumahPageState createState() => _BedahRumahPageState();
}

class _BedahRumahPageState extends State<BedahRumahPage> {
  late Future<List<dynamic>> _getData;

  @override
  void initState() {
    _getData = getData();
    super.initState();
  }

  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/bedahrumah"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _getData = getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Request Bedah Rumah',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<dynamic>>(
          future: _getData,
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
                    final bedahrumah = list[index];
                    return Card(
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Pemilik: ${bedahrumah['nama_pemilik']}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    String? pop = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditBedahRumahPage(
                                          bedahrumah: bedahrumah,
                                        ),
                                      ),
                                    );

                                    if (pop == "data-updated") {
                                      _refreshData();
                                    }
                                  },
                                  child: Icon(Icons.edit, color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Text('Alamat: ${bedahrumah['alamat']}'),
                            SizedBox(height: 5.0),
                            Text('Foto: ${bedahrumah['foto']}'),
                            SizedBox(height: 5.0),
                            Text('Keterangan: ${bedahrumah['keterangan']}'),
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
            MaterialPageRoute(builder: (context) => TambahBedahRumahPage()),
          ).then((value) {
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
