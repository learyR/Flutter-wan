import 'package:flutter/material.dart';
import 'package:flutter_wan/res/LocalRes.dart';
import 'package:flutter_wan/util/PictureSelectUtil.dart';
import 'package:sy_flutter_qiniu_storage/sy_flutter_qiniu_storage.dart';

class ViewPickerTest extends StatefulWidget {
  ViewPickerTest({Key key}) : super(key: key);

  @override
  ViewPickerTestState createState() => new ViewPickerTestState();
}

class ViewPickerTestState extends State<ViewPickerTest> {
  String filePath;

  _onUpload() async {
    //String token = '从服务端获取的token';
    String filePath =
        await PictureSelectUtil.getInstance.showSelectMenu(context);
//        .then((filePath)  {
    print('leary_filePath: ' + filePath);
    String token =
        'qd68lK_H3V2K8TTOCamgSCAwy2r6BddZKvYu3SGO:-YNVoHhTjc6wSlxLluh_hFBA2gA=:eyJzY29wZSI6InN5LWJ1Y2tldCIsImRlYWRsaW5lIjoxNTQ1OTkzNTAzLCJwZXJzaXN0ZW50T3BzIjoidmZyYW1lL2pwZy9vZmZzZXQvNy93LzQ4MC9oLzM2MHxzYXZlYXMvYzNrdFluVmphMlYwT2pFeU16UXpMbXB3Wnc9PSJ9';
    final syStorage = new SyFlutterQiniuStorage();
    //监听上传进度
    syStorage.onChanged().listen((dynamic percent) {
      print('leary_percent: ' + percent.toString());
    });
    String key = DateTime.now().millisecondsSinceEpoch.toString() +
        '.' +
        filePath.split('.').last;
    print('leary_key: ' + key);
    //上传文件
    bool result = await syStorage.upload(filePath, token, key);
    print('leary_result: ' + result.toString()); //true 上传成功，false失败
    setState(() {
      this.filePath = filePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              _onUpload();
            },
            foregroundColor: Colors.white,
            child: Text('点我'),
          ),
          SizedBox(height: 10.0),
          FloatingActionButton(
            heroTag: 'btn3',
            onPressed: () {
              SyFlutterQiniuStorage.cancelUpload();
            },
            foregroundColor: Colors.red,
            child: Text('停止'),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: 75.0,
              height: 75.0,
              child: ClipOval(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  filePath ?? LocalDrawable.mine_default_portrait,
                  fit: BoxFit.fitWidth,
                ),
              ),
            )
            //头像
            //添加头像
//            Positioned(
//                bottom: 2.0,
//                right: 2.0,
//                child: GestureDetector(
//                  onTap: () => getImage(ImageSource.gallery),
//                  child: Padding(
//                      padding: const EdgeInsets.only(top: 5.0, left: 5.0),
//                      child:
//                          Image.asset('assets/images/icon_portrait_add.png')),
//                ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
