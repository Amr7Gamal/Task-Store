import 'package:flutter/material.dart';

abstract class BaseNavigator {
  Widget logo({double size});
}

class BaseViewModel<Not extends BaseNavigator> extends ChangeNotifier {
  Not? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {

  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();



  Widget logo({double size = 150}) {
    return Padding(
    padding: EdgeInsets.only(top: 12),
    child: Image.asset(
    'assets/images/route.png',
    width: size,
    ));
  }

}