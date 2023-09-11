// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get_barcode_and_scan/screens/scanned_code.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: Text(
            " Scanning QR code ",
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
               Text("Let's Scan ",style: TextStyle(
                 fontSize: 40,
                 color: Colors.white
               ),),
                SizedBox(
                  height: 200,
                ),
                Container(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    onPressed: (){Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScannedCode(),
                      ),
                    );}  ,
                    child: Text(
                      "Go",
                      style: TextStyle(fontSize: 30),
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


}
