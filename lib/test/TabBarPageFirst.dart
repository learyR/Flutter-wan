import 'package:flutter/material.dart';

/**
 * Created by guoshuyu
 * on 2018/7/29.
 */

class TabBarPageFirst extends StatefulWidget {
  @override
  _TabBarPageFirstState createState() => _TabBarPageFirstState();
}

class _TabBarPageFirstState extends State<TabBarPageFirst>
    with AutomaticKeepAliveClientMixin {
  final _suggestions = <String>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);
  final ScrollController _scrollController = new ScrollController();

  Widget _buildRow(String pair) {
    return new ListTile(
      title: new Text(
        pair,
        style: _biggerFont,
      ),
    );
  }

  generateWordPairs() {
    return [
      "11111",
      "222222",
      "3333333",
      "4444444",
      "11111",
      "222222",
      "3333333",
      "4444444",
      "11111",
      "222222",
      "3333333",
      "4444444",
      "11111",
      "222222",
      "3333333",
      "4444444"
    ];
  }

  generateWordPairsRefresh() {
    return [
      "yyyyyyy",
      "uuuuuuu",
      "iiiiiii",
      "ooooooo",
      "ppppppp",
      "yyyyyyy",
      "uuuuuuu",
      "iiiiiii",
      "ooooooo",
      "ppppppp",
      "yyyyyyy",
      "uuuuuuu",
      "iiiiiii",
      "ooooooo",
      "ppppppp",
    ];
  }

  Widget _buildSuggestions() {
    return new RefreshIndicator(
      onRefresh: _handleRefresh,
      child: new ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          itemCount: _suggestions.length,
          controller: _scrollController,
          itemBuilder: (context, i) {
            if (i.isOdd) return new Divider();
            final index = i ~/ 2;
            // 如果是建议列表中最后一个单词对
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs());
            }
            return _buildRow(_suggestions[index]);
          }),
    );
  }

  Future<Null> _handleRefresh() async {
    if (this.mounted) {
//      setState(() {
//        _suggestions.clear();
//        _suggestions.addAll(generateWordPairsRefresh());
//        return null;
//      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(null);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return _buildSuggestions();
  }
}
