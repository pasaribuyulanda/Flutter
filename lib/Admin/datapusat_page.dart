import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tambah_pusat_page.dart';
import 'edit_pusat_page.dart';

class DataPusatPage extends StatefulWidget {
  const DataPusatPage({super.key});

  @override
  State<DataPusatPage> createState() => _DataPusatPageState();
}

class _DataPusatPageState extends State<DataPusatPage> {
  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/pusat"));
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Pusat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        elevation: 0, // Menghilangkan bayangan di bawah AppBar
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
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
                  final pusat = list[index];
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 5.0, // Menambahkan bayangan pada Card
                    shadowColor: Colors.black54, // Menambahkan warna bayangan
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nama Pusat: ${pusat['Nama_pusat']}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  String pop = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditPusatPage(pusat: pusat)),
                                  );

                                  if (pop == "data-updated") {
                                    setState(() {
                                      getData();
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Text('Kode Pusat: ${pusat['Kode_pusat']}'),
                          SizedBox(height: 5.0),
                          Text('Alamat Pusat: ${pusat['Alamat_pusat']}'),
                          SizedBox(height: 5.0),
                          Text(
                              'Nama Kepala Pusat: ${pusat['Nama_kepala_pusat']}'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahPusatPage()),
          );
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
        backgroundColor:
            Colors.red, // Latar belakang merah untuk BottomNavigationBar
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
