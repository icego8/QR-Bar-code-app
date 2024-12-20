import 'package:flutter/material.dart';
import 'package:qr_bar_code_app/BAR/BARgenrator.dart';
import 'package:qr_bar_code_app/BAR/BARscanner.dart';

class barCode extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bar Code", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("For BAR code",
              style: TextStyle(color: Colors.purple,fontSize: 50,fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 250,
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> BARscanner()));
                },
                child: const Text("scanner",style: TextStyle(fontSize: 20),)
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> BARgenerator()));
                },
                child: const Text("generator",style: TextStyle(fontSize: 20),)
            ),
          ],
        ),
      ),
    );
  }

}