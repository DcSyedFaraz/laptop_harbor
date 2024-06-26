import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  late User _user;
  String _name = '';
  String _contact = '';
  String _profilePictureUrl = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final userDoc = await _firestore.collection('users').doc(_user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _name = userDoc.data()!['name'] ?? '';
          _contact = userDoc.data()!['contact'] ?? '';
          _profilePictureUrl = userDoc.data()!['profilePictureUrl'] ?? '';
          _nameController.text = _name;
          _contactController.text = _contact;
        });
      } else {
        Fluttertoast.showToast(msg: 'User document not found');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching user data: $e');
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _firestore.collection('users').doc(_user.uid).set({
          'name': _name,
          'contact': _contact,
          'profilePictureUrl': _profilePictureUrl,
        }, SetOptions(merge: true));
        Fluttertoast.showToast(msg: 'Profile updated successfully');
        Navigator.pop(context);
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error: $e');
      }
    }
  }

  Future<void> _selectImage() async {
    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final file = File(image.path);
        final ref = _storage.ref().child('profilePictures').child(_user.uid);

        // Upload the file
        final uploadTask = ref.putFile(file);

        // Get the download URL after the upload is complete
        final snapshot = await uploadTask.whenComplete(() => null);
      print('file here $file new $snapshot');
        final url = await snapshot.ref.getDownloadURL();

        setState(() {
          _profilePictureUrl = url;
        });

        Fluttertoast.showToast(msg: 'Image uploaded successfully');
      } else {
        Fluttertoast.showToast(msg: 'No image selected');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: 'Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: _profilePictureUrl.isNotEmpty
                    ? NetworkImage(_profilePictureUrl)
                    : null,
                child: _profilePictureUrl.isEmpty
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: _selectImage,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Name cannot be empty' : null,
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
                validator: (value) =>
                    value!.isEmpty ? 'Contact cannot be empty' : null,
                onSaved: (value) => _contact = value!,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }
}
