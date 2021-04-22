import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File imageFile;
  final picker = ImagePicker();

  openGallery(BuildContext context) async {
    final picture = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.of(context).pop();
  }

  openCamera(BuildContext context) async{
    final picture = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Make a choice!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  openGallery(context);
                },
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget decideImageContent(){
    if(imageFile == null){
      return Text('No image selected!');
    }else {
      return Image.file(imageFile,width: 400, height: 500);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              decideImageContent(),
              RaisedButton(
                onPressed: () {
                  showChoiceDialog(context);
                },
                child: Text('Select Image!'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
