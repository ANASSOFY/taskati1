import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/widgets/app_bottom.dart';
import 'home_screens.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  File? pickedImage;
  final TextEditingController nameController = TextEditingController();

  Future pickFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (image == null) return;

    setState(() {
      pickedImage = File(image.path);
    });
  }

  Future pickFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;

    setState(() {
      pickedImage = File(image.path);
    });
  }

  void onDone() {
  final name = nameController.text.trim();

  if (name.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter your name")),
    );
    return;
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => HomeScreens(userName: name),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // -------- Avatar --------
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

            const SizedBox(height: 25),
            const Divider(thickness: 2),
            const SizedBox(height: 20),

            // -------- Name Field --------
            SizedBox(
              width: 280,
              child: TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

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
