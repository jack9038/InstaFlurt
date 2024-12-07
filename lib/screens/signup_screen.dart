import 'dart:typed_data';

// import 'package:encrypt/encrypt.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaflurt/resources/auth_method.dart';
import 'package:instaflurt/screens/text_field.dart';
import 'package:instaflurt/utils/utils_images.dart';

// ignore: camel_case_types
class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

// ignore: camel_case_types
class _signupScreenState extends State<signupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    String result = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      image: _image!,
    );

    if (result != 'success') {
      showSnackBar(result, context);
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //title InstaFlurt

                Text(
                  'InstaFlurt',
                  style: GoogleFonts.lemon(fontSize: 50),
                ),

                const SizedBox(
                  height: 30,
                ),
                //image input
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                                'D:/src/instaflurt/default_pro_pic.png'),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                //username
                textFieldWidget(
                  textEditingController: _usernameController,
                  hintText: 'Enter Your username',
                  textInputType: TextInputType.text,
                ),

                const SizedBox(
                  height: 25,
                ),

                //text field input for email

                textFieldWidget(
                  textEditingController: _emailController,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress,
                ),

                const SizedBox(
                  height: 25,
                ),

                //text field input for password

                textFieldWidget(
                  textEditingController: _passwordController,
                  hintText: 'Enter Your Password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),

                //////////////////

                /////////////////

                const SizedBox(
                  height: 25,
                ),

                textFieldWidget(
                  textEditingController: _bioController,
                  hintText: 'Enter your bio info',
                  textInputType: TextInputType.text,
                ),

                const SizedBox(
                  height: 25,
                ),

                //buttonfor signup

                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        color: Colors.blue),
                    child: const Text('sign up'),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //transisioning to sign up

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't you have an account? "),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Sign up.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 300,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
