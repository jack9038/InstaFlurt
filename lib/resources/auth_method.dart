// import 'dart:typed_data';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instaflurt/resources/storage_methods.dart';
import 'package:instaflurt/utils/encrypt.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List image,
  }) async {
    String result = "some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          image != null) {
        //register yourself
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilepic', image, false);
        // use of firestore
        await _firestore.collection('Users').doc(cred.user!.uid).set({
          'Username': EncryptionDecryption.encryptMessage(username),
          'Bio': EncryptionDecryption.encryptMessage(bio),
          'Image': image,
          'Email': EncryptionDecryption.encryptMessage(email),
          'uid': cred.user!.uid,
          'followers': [],
          'following': [],
          'profilepic': photoUrl,
        });
        result = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        result = 'email is badly formatted';
      } else if (err.code == 'weak-password') {
        result = 'password must contain aleast 6 characters';
      }
    } on FirebaseException catch (err) {
      if (err.code == 'object-not-found') {
        result = 'user not found';
      }
      result = err.code.toString();
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
}
