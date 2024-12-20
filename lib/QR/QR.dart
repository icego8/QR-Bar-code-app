import 'package:flutter/material.dart';
import 'package:qr_bar_code_app/QR/QRgenerator.dart';
import 'package:qr_bar_code_app/QR/QRscanner.dart';

class qrCode extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("For QR code",
              style: TextStyle(color: Colors.blue,fontSize: 50,fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 250,
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> QRscanner()));
                },
                child: const Text("scanner",style: TextStyle(fontSize: 20),)
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> QRgenerator()));
                },
                child: const Text("generator",style: TextStyle(fontSize: 20),)
            ),
          ],
        ),
      ),
    );
  }

}