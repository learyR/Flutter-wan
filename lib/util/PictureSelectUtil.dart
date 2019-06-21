import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

///相机相册 工具类
class PictureSelectUtil {
  factory PictureSelectUtil() => _getInstance();

  static PictureSelectUtil _instance;

  static PictureSelectUtil get getInstance => _getInstance();

  static PictureSelectUtil _getInstance() {
    if (_instance == null) {
      _instance = PictureSelectUtil._init();
    }
    return _instance;
  }

  PictureSelectUtil._init() {}

  ///弹出选择菜单
  Future<String> showSelectMenu(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => false,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildItem(0, context),
                  Divider(height: 1.0),
                  _buildItem(1, context),
                  Container(height: 10.0),
                  _buildItem(2, context)
                ],
              ),
            ),
          );
        });
  }

  Widget _buildItem(int index, BuildContext context) {
    List<String> title = ['从相册选择图片', '拍照', '取消'];
    return GestureDetector(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          height: 48.0,
          child: Text(
            title[index],
            style: TextStyle(fontSize: 17.0, color: Colors.black38),
          ),
        ),
        onTap: () {
          if (index == 0) {
            ImagePicker.pickImage(source: ImageSource.gallery)
                .then((File value) {
              _cropImage(value, context);
            });
          } else if (index == 1) {
            ImagePicker.pickImage(source: ImageSource.camera)
                .then((File value) {
              _cropImage(value, context);
            });
          }
        });
  }

  ///裁剪头像
  _cropImage(File imageFile, BuildContext context) async {
    File file = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxHeight: 512,
        maxWidth: 512);
    Navigator.of(context).pop(file.path);
  }
}
