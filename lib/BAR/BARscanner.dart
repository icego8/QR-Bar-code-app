import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BARscanner extends StatefulWidget {
  const BARscanner({super.key});

  @override
  State<BARscanner> createState() => _scannerState();
}

class _scannerState extends State<BARscanner> {
  var txt1="Scanned Data will appear here";
  Future<void> scanBarcode()async{
    try{
      var BARCode = await SimpleBarcodeScanner.scanBarcode(context, scanType: ScanType.barcode, isShowFlashIcon: true,);
      // var BARCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'cancel', true, ScanMode.QR) ;
      //   here async keyword alllows to use await keyword
      //   here grstr waits for the result deu to await keyword
      //   by using these two keyword we can sync an asychronous function(takes unkown amount of time to complete)
      if(!mounted){
        return;
      }
      else {
        setState(() {
          txt1= BARCode.toString();
          isButtonEnabled= (txt1 != "-1") ? true : false;
          txt1= (txt1 == "-1") ?"Not Scanned": txt1;
        });
      }
    }on PlatformException{
      txt1="Scanning failed";
    }
  }
  bool isButtonEnabled=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Scan BAR"),
      ),
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(txt1,style: TextStyle(fontSize: 20,color: Colors.white70),),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: ()=>scanBarcode(),
                style:ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                ),
                child: Container(
                  width: 45,
                  height: 90,
                  child: Center(
                      child: FaIcon(FontAwesomeIcons.barcode, color: Colors.black, size: 50,)
                  ),
                )
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: isButtonEnabled ? (){
              FlutterClipboard.copy(txt1);
              Fluttertoast.showToast(msg: "Copied!!",timeInSecForIosWeb: 2);
            }:null,
                child: Text("Copy"))
          ],
        ),
      ),
    );
  }
}

