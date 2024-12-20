import 'package:qr_bar_code_app/BAR/BAR.dart';
import 'package:qr_bar_code_app/QR/QR.dart';
import 'package:qr_bar_code_app/QR/QRgenerator.dart';
import 'package:qr_bar_code_app/QR/QRscanner.dart';
import 'package:flutter/material.dart';

class MyAppHome extends StatelessWidget{
  const MyAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("QR-BAR Code APP",
              style: TextStyle(color: Colors.blue,fontSize: 40,fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 200,
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> qrCode()));
                },
                child: const Text("QR Code",style: TextStyle(fontSize: 20),)
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> barCode()));
                },
                child: const Text("BAR Code",style: TextStyle(fontSize: 20),)
            ),
          ],
        ),
      ),
    );
  }

}