import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'todo_edit_page/page.dart';
import 'todo_list_page/page.dart';

class FishReduxTest extends StatefulWidget {
  @override
  FishReduxTestState createState() => new FishReduxTestState();
}

class FishReduxTestState extends State<FishReduxTest> {
  final AbstractRoutes routes = HybridRoutes(routes: <AbstractRoutes>[
    PageRoutes(pages: <String, Page<Object, dynamic>>{
      'todo_list': ToDoListPage(),
      'todo_edit': ToDoEditPage(),
    })
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Navigator(
        initialRoute: 'todo_list',
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute<Object>(builder: (BuildContext context) {
            return routes.buildPage(settings.name, settings.arguments);
          });
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(FishReduxTest oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
