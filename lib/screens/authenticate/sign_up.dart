import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:souncloud_clone/services/auth.dart';
import 'package:souncloud_clone/services/database_service.dart';
import 'package:souncloud_clone/services/storage_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  MemoryImage? image;
  FilePickerResult? _result;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageService _storageService = StorageService();
  final DatabaseService _databaseService = DatabaseService();
  final AuthencationService _authService = AuthencationService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String gender = 'Male';
  String username = '';
  String email = '';
  String password = '';
  String error = '';

  void pickImage() async {
    try {
      if (kIsWeb) {
        _result = await FilePickerWeb.platform.pickFiles(
          type: FileType.image,
        );
      } else {
        _result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
      }

      setState(() {
        Uint8List? imageBytes = _result!.files.first.bytes;
        image = imageBytes != null ? MemoryImage(imageBytes) : null;
        print(image);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      dynamic result = await _authService.registerUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("Get result");

      if (result == null) {
        setState(() {
          error = "Something went wrong";
        });
        return;
      } else {
        print(result);
      }

      String? imageUrl = '';
      if (image != null) {
        imageUrl = await _storageService.uploadImage(
          bytes: image!.bytes,
          id: FirebaseAuth.instance.currentUser!.uid.toString(),
          folder: 'profilePics',
        );
      }

      await _databaseService.createUserRecord(
        uid: FirebaseAuth.instance.currentUser!.uid.toString(),
        username: _usernameController.text,
        gender: gender,
        photoUrl: imageUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // String? genderDropdownValue = widget.genderList.first;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 60.0),
              Center(
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Create your account",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: image,
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter a username' : null,
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.email),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an email' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.purple.withOpacity(0.1),
                      ),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Gender',
                          border: InputBorder.none,
                          icon: const Icon(Icons.person),
                        ),
                        value: 'Male',
                        onChanged: (String? value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                        items: <String>['Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                      validator: (value) => value!.length < 8
                          ? 'Enter a password 8+ chars long'
                          : null,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                child: ElevatedButton(
                  onPressed: () async {
                    await _signUp();
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.purple,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      widget.toggleView!();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.purple),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
