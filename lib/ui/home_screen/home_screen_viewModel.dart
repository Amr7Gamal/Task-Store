import 'package:task/dataBase/network.dart';
import 'package:task/model/project.dart';

import '../../../base/base.dart';

abstract class HomeScreenNavigator extends BaseNavigator {
  void setStateScreen();
}

class HomeScreenViewModel extends BaseViewModel<HomeScreenNavigator> {
  int screenIndex = 0;
  List<Products> results = [];
  List<Products> products = [];

  void getProducts() async {
    products = await Network.getProducts() ?? [];
    notifyListeners();
  }


  int calculateOriginalPrice(double discountedPrice, double discountPercentage) {
    if (discountPercentage <= 0 || discountPercentage >= 100) {
      throw ArgumentError("Discount percentage must be between 0 and 100");
    }
    return (discountedPrice / (1 - (discountPercentage / 100))).toInt();
  }


  void search(String text) {
    print(text);
    if (text.isEmpty || text == "") {
      screenIndex = 0;
      print(1);
      results.removeLast();
    } else {
      results = products.where((product) =>
          product.title!.toLowerCase().contains(text.toLowerCase()))
          .toList();;

      notifyListeners();
      if (screenIndex != 1) {
        screenIndex = 1;
      }
    }
    // navigator!.setStateScreen();
  }

}
