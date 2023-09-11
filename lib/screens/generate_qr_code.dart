// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:typed_data';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  String qrText = "";

  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
          resizeToAvoidBottomInset :true ,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            centerTitle: true,
            title: Text(
              " Get QR code ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildWidget(),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      maxLines: 10,
                      onChanged: (value) {
                        setState(() {
                          qrText = value;
                        });
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter your data here",
                        hintStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(150, 20),
                            backgroundColor: Colors.orange),
                        onPressed: () async {
                          final image =
                              await controller.captureFromWidget(buildWidget());
                          await saveImage(image);
                        },
                        child: Text(
                          "Save Image",
                          style: TextStyle(fontSize: 18),
                        )),
                    
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = 'Screen Shot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  Widget buildWidget() => BarcodeWidget(
        data: qrText,
        barcode: Barcode.qrCode(),
        color: Colors.white,
        height: 350,
        width: 300,
      );
}
