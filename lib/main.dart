// ignore_for_file: await_only_futures

import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:barcode_image/barcode_custom.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Barcode'),
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
  String imageNew = '';
  Future<String> _readLevelFile() async {
    Directory? appDocDir = await getDownloadsDirectory();
    String appDocPath = appDocDir!.path;
    File file = File(appDocPath);
    print("getDownloadsDirectory $appDocDir");
    imageNew = "${await file.path}/code-128c.svg";

    String fileName = "code-128c";

    return await imageNew;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readLevelFile();
  }

  void _incrementCounter() async {
    buildBarcode(
      Barcode.code128(useCode128A: false, useCode128B: false),
      '0123456789',
      filename: 'code-128c',
    );
    buildBarcode(
      Barcode.qrCode(),
      'QR-Code',
      height: 200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(File(imageNew)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
