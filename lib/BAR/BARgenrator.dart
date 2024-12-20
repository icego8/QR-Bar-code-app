import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class BARgenerator extends StatefulWidget{
  @override
  State<BARgenerator> createState() => _generatorState();
}

class _generatorState extends State<BARgenerator> {
  Future<void> shareImage() async {
    try{
      RenderRepaintBoundary boundary = barKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_image.png').create();
      await file.writeAsBytes(pngBytes);
      Share.shareXFiles([XFile(file.path)],text: "Share this QR Code!");
    }
    catch(e){
      Fluttertoast.showToast(msg: "First Enter the Text to generate QR Code");
      print(e);
    }
  }
  Future<void> captureImage() async {
    try {
      RenderRepaintBoundary boundary = barKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0); // Adjust pixelRatio as needed
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final result = await SaverGallery.saveImage(pngBytes, fileName: "qr", skipIfExists: false);
      // final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: 'qr_code.png');
      print(result); // Check if saving was successful
      Fluttertoast.showToast(msg: "QR Image Saved!");
    }
    catch (e) {
      Fluttertoast.showToast(msg: "First Enter the Text to generate QR Code");
      print(e); // Handle any errors during the process
    }
  }
  var txt=TextEditingController();
  final barKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Generate BAR"),
      ),
      backgroundColor: Colors.purple.shade200,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(txt.text.isNotEmpty) Container(
                height: 100,
                width: 200,
                child: Container(
                  child: BarcodeWidget(
                    barcode: Barcode.code128(), // or any other barcode type
                    data: txt.text,
                    width: 200,
                    height: 100,
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  ),
                ),
                color: Colors.white,
              ),
              // this methgd is used when we add a widget after a particular condition
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: 300,
                child: TextField(
                  controller: txt,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "enter text to genrate QR code",
                    hintStyle: TextStyle(color: Colors.white38),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                  });
                },
                child: Text("generate",style: TextStyle(fontSize: 15),),
              ),
              SizedBox(
                height:  20,
              ),
              if(txt.text.isNotEmpty) Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                        tooltip: "download",
                        onPressed: captureImage,
                        icon: FaIcon(FontAwesomeIcons.download, color: Colors.white,)),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                        onPressed:shareImage,
                        icon: FaIcon(FontAwesomeIcons.share, color: Colors.white,)),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}