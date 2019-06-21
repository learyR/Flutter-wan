import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wan/res/LocalRes.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ViewPickerTest extends StatefulWidget {
  @override
  ViewPickerTestState createState() => new ViewPickerTestState();
}

class ViewPickerTestState extends State<ViewPickerTest> {
  Future<File> _imageFile;

  void getImage(ImageSource source) {
    ImagePicker.pickImage(source: source).then((File value) {
      setState(() {
        _imageFile = _cropImage(value);
      });
    });
  }

  Future<File> _cropImage(File imageFile) async {
    return await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxHeight: 512,
        maxWidth: 512);
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Container(
              width: 75.0,
              height: 75.0,
              child: ClipOval(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.file(
                  snapshot.data,
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
          } else if (snapshot.error != null) {
            //error
            return Image.asset(LocalDrawable.mine_default_portrait);
          } else {
            return Image.asset(LocalDrawable.mine_default_portrait);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text("Camera"),
                      onTap: () async {
                        getImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text("Gallery"),
                      onTap: () async {
                        getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        },
        foregroundColor: Colors.white,
        child: Text('点我'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            //头像
            _previewImage(),
            //添加头像
            Positioned(
                bottom: 2.0,
                right: 2.0,
                child: GestureDetector(
                  onTap: () => getImage(ImageSource.gallery),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                      child:
                          Image.asset('assets/images/icon_portrait_add.png')),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(ViewPickerTest oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
