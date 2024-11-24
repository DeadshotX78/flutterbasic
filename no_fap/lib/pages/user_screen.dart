import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:no_fap/components/setting_tile.dart';
import 'package:no_fap/constants.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String? username;
  String? email;
  String? profilePicUrl;
  File? image;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          username = userDoc['username'];
          email = userDoc['email'];
          profilePicUrl = userDoc['profilePicUrl'];
        });
      }
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && image != null) {
      String fileName = '${user.uid}.jpg';
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName);

      UploadTask uploadTask = storageRef.putFile(image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'profileImageUrl': downloadUrl,
      });

      setState(() {
        profilePicUrl = downloadUrl;
      });
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //user profile pic
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profilePicUrl != null
                      ? NetworkImage(profilePicUrl!)
                      : const AssetImage('lib/assets/images/google.png'),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: pickImage,
                    icon: const Icon(Icons.camera_alt_rounded),
                  ),
                ),
              ],
            ),
           
            const SizedBox(height: 5),
            //username
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Text(
                '$username',
                style: const TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 10),
            //profile functions [
            //edit profile
            SettingTile(
              onTap: () {},
              text: 'Edit Information',
              icon: Icons.person,
            ),
            const SizedBox(height: 10),
            //update payment methods
            SettingTile(
              onTap: () {},
              text: 'Payment Methods',
              icon: Icons.credit_card,
            ),
            const SizedBox(height: 10),
            //chat with customer care
            SettingTile(
              onTap: () {},
              text: 'Customer Care',
              icon: Icons.phone,
            ),
            const SizedBox(height: 10),
            // ]
            // exit or logout
            SettingTile(
              onTap: signOut,
              text: 'Exit',
              icon: Icons.exit_to_app_rounded,
            )
          ],
        ),
      ),
    );
  }
}
