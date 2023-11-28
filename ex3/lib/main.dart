import 'dart:io';

import 'package:ex3/google_app_script_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const MyHomePage(title: '20204538'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _link;
  String? _driveLink;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      setState(() {
        _link = pref.getString("download");
        _driveLink = pref.getString("drive");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Avatar hiện tại (Link drive: $_driveLink):',
              textAlign: TextAlign.center,
            ),
            if (_link != null && _link != "")
              Image.network(
                _link!,
                width: 200,
                cacheWidth: 200,
                errorBuilder: (err, object, stack) {
                  return const FlutterLogo();
                },
              )
            else
              const CircularProgressIndicator(),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _link = null;
                    _driveLink = null;
                  });
                  ImagePicker().pickImage(source: ImageSource.gallery).then((xfile) {
                    if (xfile == null) return;
                    GAS()
                        .upload(File(xfile.path), xfile.name, xfile.mimeType ?? "image/jpeg")
                        .then((value) {
                      SharedPreferences.getInstance().then((pref) {
                        pref
                          ..setString("download", value?["download"] ?? "")
                          ..setString("drive", value?["drive"] ?? "");
                      });
                      setState(() {
                        _link = value?["download"];
                        _driveLink = value?["drive"];
                      });
                    });
                  });
                },
                child: const Text("Đăng ảnh"))
          ],
        ),
      ),
    );
  }
}
