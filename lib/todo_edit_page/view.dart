import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ToDoEditState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("toDo"),
    ),

    ///最外层
    body: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            ///第一行 标题
            child: Row(
              children: <Widget>[
                Container(
                  child: const Text(
                    "title:",
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  width: 56.0,
                  alignment: AlignmentDirectional.topEnd,
                ),

                /// 标题编辑框
                Expanded(
                  child: Container(
                    color: const Color(0xffe0e0e0),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(left: 8.0),

                    ///输入框
                    child: EditableText(
                        //相当于id
                        controller: state.nameEditController,
                        //焦点获取
                        focusNode: state.focusNodeName,
                        //输入的字体 样式
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16.0),
                        //指针颜色
                        cursorColor: Colors.blue,
                        backgroundCursorColor: const Color(0xffff59d)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 32.0),
              alignment: AlignmentDirectional.topStart,

              ///第二行 描述
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: const Text(
                      "desc:",
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    width: 56.0,
                    alignment: AlignmentDirectional.topEnd,
                  ),

                  /// 标题编辑框
                  Expanded(
                    child: Container(
                      color: const Color(0xffe0e0e0),
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(left: 8.0),
//                      alignment: Alignment.topCenter,

                      ///输入框
                      child: EditableText(
                          //相当于id
                          controller: state.descEditController,
                          //焦点获取
                          focusNode: state.focusNodeDesc,
                          //输入的字体 样式
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                          //指针颜色
                          maxLines: 10,
                          cursorColor: Colors.blue,
                          backgroundCursorColor: const Color(0xffe0e0e0)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => dispatch(ToDoEditActionCreator.done()),
      tooltip: 'Done',
      child: const Icon(Icons.done),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );
}
