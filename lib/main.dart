

import 'package:flutter/material.dart';
import 'package:flutter_navigation/account_page.dart';
import 'package:flutter_navigation/chat_page.dart';
import 'package:flutter_navigation/MyCountChangeNotifier.dart';
import 'package:flutter_navigation/home_page.dart';
import 'package:provider/provider.dart';
import 'MyCountChangeNotifier.dart';
void main() {
  runApp(ProviderApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body:BottomNavigationController(),
      ),
    );
  }
}


class BottomNavigationController extends StatefulWidget {
  BottomNavigationController({Key key}) :super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _currentIndex = 0; //預設值
  final pages = [HomePage(),ChatPage(),AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("測試首頁"),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items:<BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          title: Text("home")),
          BottomNavigationBarItem(icon: Icon(Icons.chat),
              title: Text("chat")),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),
              title: Text("account")),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.amber,
        onTap: _onItemClick,
      ),
    );
  }
  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class ProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(notifier: MyCountChangeNotifier())
      ],
      child: MaterialApp(
        home: HomePage2(),
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //透過 Provider.of 來獲取資料
    final counter = Provider.of<MyCountChangeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('clone仔的測試'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '目前計數值: ${counter.count}',
            ),
            RaisedButton(
              //點擊按鈕後，導轉跳到B頁
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BPage()),
              ),
              child: Text('跳次頁'),
            ),
          ],
        ),
      ),
    );
  }
}

class BPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B頁'),
      ),
      body: Center(
        // 透過 Consumer 來接收更改對應資料
        child: Consumer<MyCountChangeNotifier>(builder: (context, counter, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '目前計數值:',
              ),
              Text(
                '${counter.count}',
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 使用 Provider.of，並且將 listen 設定為 false(若沒設定，預設為 true)，
          // 則不會再次調用 Widget 重新構建（ build ）畫面 ，更省效能。
          Provider.of<MyCountChangeNotifier>(context, listen: false)
              .increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
