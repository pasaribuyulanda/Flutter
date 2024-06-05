import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pptsb/User/beasiswa.dart';
import 'package:pptsb/User/bedah_rumah.dart';

class RequestPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Menu'),
        backgroundColor: Color(0xFFC0210B),
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
        selectedItemColor: Color(0xFFC0210B),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/back.jpg', // Path to your background image
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                RequestCard(
                  title: 'Request Bedah Rumah',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BedahRumahPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                RequestCard(
                  title: 'Request Beasiswa Prestasi',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeasiswaPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const RequestCard({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 75,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFC0210B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class RequestForm extends StatefulWidget {
  final String requestType;
  final List<String> formFields;
  final bool showUploadButton;

  const RequestForm({
    Key? key,
    required this.requestType,
    required this.formFields,
    this.showUploadButton = true,
  }) : super(key: key);

  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  List<TextEditingController> controllers = [];
  File? _image;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.formFields.length,
      (index) => TextEditingController(),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _submitForm() {
    Map<String, String> requestData = {};
    for (int i = 0; i < widget.formFields.length; i++) {
      requestData[widget.formFields[i].replaceAll(' ', '_').toLowerCase()] =
          controllers[i].text;
    }

    print("Menu Request Data: $requestData");
    if (_image != null) {
      print("Image Path: ${_image!.path}");
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form data collected')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Form untuk request ${widget.requestType}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ...List.generate(widget.formFields.length, (index) {
                return TextField(
                  controller: controllers[index],
                  decoration:
                      InputDecoration(labelText: widget.formFields[index]),
                );
              }),
              SizedBox(height: 20),
              if (widget.showUploadButton) ...[
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Upload Image'),
                ),
                _image != null
                    ? Image.file(_image!)
                    : Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          'No image selected.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: RequestPages(),
  ));
}
