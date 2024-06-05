import 'package:flutter/material.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  Widget _buildCard(String cardText, Color color, IconData icon) {
    return Card(
      elevation: 5.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 10.0),
            Text(
              cardText,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      0, AppBar().preferredSize.height, 0, 0),
                  items: <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Text('Data Pusat'),
                      value: '/dataPusat',
                    ),
                    PopupMenuItem(
                      child: Text('Data Regional'),
                      value: '/dataRegional',
                    ),
                    PopupMenuItem(
                      child: Text('Data Cabang'),
                      value: '/dataCabang',
                    ),
                    PopupMenuItem(
                      child: Text('Data Sektor'),
                      value: '/dataSektor',
                    ),
                    PopupMenuItem(
                      child: Text('Data Anggota'),
                      value: '/dataAnggota',
                    ),
                    PopupMenuItem(
                      child: Text('Data Pengurus PPTSB'),
                      value: '/dataJabatan',
                    ),
                    PopupMenuItem(
                      child: Text('Data Beasiswa Anggota'),
                      value: '/dataBeasiswa',
                    ),
                  ],
                  elevation: 8.0,
                ).then((value) {
                  if (value == '/logout') {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  } else if (value != null) {
                    Navigator.pushNamed(context, value);
                  }
                });
              },
            ),
            Spacer(),
            Text(
              'Administrator',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Spacer(),
            PopupMenuButton(
              icon: Icon(Icons.account_circle),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  value: '/profile',
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                  value: '/logout',
                ),
              ],
              onSelected: (value) {
                if (value == '/logout') {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                } else {
                  Navigator.pushNamed(context, value);
                }
              },
            ),
          ],
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Data Administrasi PPTSB',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              children: [
                _buildCard('Data Regional', Colors.red, Icons.business),
                _buildCard('Data Cabang', Colors.blue, Icons.location_city),
                _buildCard('Data Sektor', Colors.green, Icons.work),
                _buildCard('Data Anggota', Colors.orange, Icons.store),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
