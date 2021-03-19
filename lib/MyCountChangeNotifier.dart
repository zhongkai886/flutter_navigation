import 'package:flutter/foundation.dart';

class MyCountChangeNotifier with ChangeNotifier{
  int _count = 0 ;

  int get count => _count;
  int get countDouble => _count*10;

  increment(){
    _count++;
    notifyListeners();
  }
}