import 'dart:async';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:souncloud_clone/services/database_service.dart';
import 'package:souncloud_clone/services/storage_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  final StorageService _storageService = StorageService();
  final DatabaseService _databaseService = DatabaseService();

  FilePickerResult? _result;
  bool isUploading = false;
  bool uploadSuccess = false;
  MemoryImage? image;

  bool songPicked = false;
  String selectedGenre = 'Sad';
  String msg = 'No file selected';

  void pickSong() async {
    try {
      if (kIsWeb) {
        _result = await FilePickerWeb.platform.pickFiles(
          type: FileType.audio,
        );
      } else {
        _result = await FilePicker.platform.pickFiles(
          type: FileType.audio,
        );
      }
      setState(() {
        songPicked = true;
        msg = _result!.files.first.name;
      });
    } catch (e) {
      print(e);
    }
  }

  void uploadSong() async {
    setState(() {
      isUploading = true;
    });

    String title = (_titleController.text == '')
        ? _result!.files.first.name
        : _titleController.text;

    try {
      String? url = await _storageService.uploadSong(
        file: _result!.files.first,
        title: title,
      );

      String? imageUrl = '';
      if (image != null) {
        imageUrl = await _storageService.uploadImage(
          bytes: image!.bytes,
          id: '${title}_${FirebaseAuth.instance.currentUser!.uid.toString()}',
          folder: 'song_covers',
        );
      }

      await _databaseService.createSongRecord(
        songId: '${title}_${FirebaseAuth.instance.currentUser!.uid.toString()}',
        title: title,
        artist: _artistController.text,
        genre: selectedGenre,
        fileUrl: url,
        coverUrl: imageUrl,
      );

      setState(() {
        uploadSuccess = true;
      });

      Timer(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacementNamed(context, '/home');
        },
      );
    } catch (e) {
      print(e);
    }

    setState(() {
      isUploading = false;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _uploadd(context),
              _fileSelectMessage(context),
              _inputField(context),
            ],
          ),
        ),
      ),
    );
  }

  _uploadd(context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: image,
            radius: 50,
          ),
          IconButton(
            onPressed: () async {
              pickImage();
            },
            icon: const Icon(
              Icons.add_a_photo,
              color: Colors.teal,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Upload Song",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Please give relative details to upload song"),
      ],
    );
  }

  _fileSelectMessage(context) {
    return Text(
      msg,
      style: TextStyle(color: Colors.red),
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _titleController,
          enabled: songPicked,
          decoration: InputDecoration(
            hintText: "Title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.title),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _artistController,
          enabled: songPicked,
          decoration: InputDecoration(
            hintText: "Artist",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person_2_rounded),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.purple.withOpacity(0.1),
          ),
          child: DropdownButton<String>(
            value: selectedGenre,
            onChanged: songPicked
                ? (String? newValue) {
                    setState(() {
                      selectedGenre = newValue!;
                    });
                  }
                : null,
            items: <String>[
              'Sad',
              'Pop',
              'Rock',
              'Electronic',
              'Satanic',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            pickSong();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            "Pick Song",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        if (!isUploading)
          ElevatedButton(
            onPressed: () async {
              uploadSong();
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.purple,
            ),
            child: const Text(
              "Upload",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        else
          const SpinKitCubeGrid(
            color: Colors.purple,
            size: 50.0,
          ),
        const SizedBox(height: 10),
        if (uploadSuccess)
          const Text(
            "Upload Success",
            style: TextStyle(color: Colors.green),
          ),
      ],
    );
  }
}
