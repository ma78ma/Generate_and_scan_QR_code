// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannedCode extends StatefulWidget {
  const ScannedCode({super.key});

  @override
  State<ScannedCode> createState() => _ScannedCodeState();
}

class _ScannedCodeState extends State<ScannedCode> {
  String qrText = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          " Scanned Code ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 170,
                  width: 380,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3, color: Colors.orange)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SelectableText(
                      qrText,
                      maxLines: 4,
                      scrollPhysics: ClampingScrollPhysics(),
                      toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
                      showCursor: true,
                      cursorColor: Colors.orange,
                      cursorWidth: 2,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                IconButton(
                  iconSize: 35,
                  color: Colors.orange,
                  onPressed: () {
                    Uri uri = Uri.parse(qrText);
                    launchUrl(uri);
                    LaunchMode.platformDefault;
                  },
                  icon: Icon(Icons.launch_outlined),
                ), //icon that go to the url
                SizedBox(
                  height: 300,
                ),
                Container(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    onPressed: scanQR,
                    child: Text(
                      "Press to scan",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode(
              "#FFA500", "Cancel", true, ScanMode.DEFAULT)
          .then((value) {
        setState(() {
          qrText = value ;
        });
      });
    } catch (e) {
      setState(() {
        qrText = 'unable to read this';
      });
    }
  }
}
