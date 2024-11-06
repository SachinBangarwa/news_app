import 'package:flutter/cupertino.dart';
import 'package:news_app/modal/news_modal.dart';

class FavouriteProvider with ChangeNotifier{
  List<Articles> resultList = [];

  void getResult(fetchedResults){
    resultList=fetchedResults;
    notifyListeners();

  }
}