import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:taskati/widgets/app_bottom.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  File? pickedImage;
  final TextEditingController nameController = TextEditingController();

  Future pickFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;

    setState(() {
      pickedImage = File(returnedImage.path);
    });
  }

  Future pickFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;

    setState(() {
      pickedImage = File(returnedImage.path);
    });
  }

  void onDone() {
    final name = nameController.text.trim();
    if (name.isEmpty) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(   
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,   
          children: [
            CircleAvatar(
              radius: 90,
              backgroundColor: Colors.black,
              backgroundImage:
                  pickedImage != null ? FileImage(pickedImage!) : null,
              child: pickedImage == null
                  ? const Icon(
                      Icons.person,
                      size: 120,
                      color: Colors.deepPurple,
                    )
                  : null,
            ),

            const SizedBox(height: 20),

            AppBottom(
              title: "Upload from Camera",
              onPressed: pickFromCamera,
            ),

            const SizedBox(height: 12),

            AppBottom(
              title: "Pick from Gallery",
              onPressed: pickFromGallery,
            ),

            const SizedBox(height: 20),

         
            SizedBox(
              width: 280,
              child: TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
            
            AppBottom(
              title: "Done",
              onPressed: onDone,
            ),
          ],
        ),
      ),
    );
  }
}
