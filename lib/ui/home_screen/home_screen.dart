import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/base.dart';
import '../../base/myTheme.dart';
import '../../model/project.dart';
import 'home_screen_viewModel.dart';

class HomeScreen extends StatefulWidget {
  static const String nameKey = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeScreenViewModel>
    implements HomeScreenNavigator {
  List<Widget> screens = [];

  @override
  Widget build(BuildContext context) {
    viewModel.getProducts();

    screens = [home(), search()];

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => viewModel,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: SafeArea(
            child: Column(
              children: [appBar(), Expanded(child: home())],
            ),
          ),
        ),
      ),
    );
  }

  Widget home() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<HomeScreenViewModel>(builder: (context, viewModel, _) {
          return viewModel.results.isNotEmpty
              ? products(viewModel.results)
              : viewModel.products.isNotEmpty
                  ? products(viewModel.products)
                  : Center(child: CircularProgressIndicator());
        }),
      ],
    );
  }

  Widget search() {
    return Consumer<HomeScreenViewModel>(
      builder: (context, viewModel, _) {
        return products(viewModel.results);
      },
    );
  }

  Widget appBar() {
    return Column(
      children: [
    viewModel.navigator!.logo(),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 18, horizontal: 4),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(28),
                    color: MyTheme.whiteColor),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.search_sharp,
                        size: 38,
                        color: Theme.of(context).primaryColor,
                      )),
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        viewModel.search(text);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          "What do you searsh for?",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: MyTheme.paragraphColor),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 38,
                  color: Theme.of(context).primaryColor,
                )),
          ],
        ),
      ],
    );
  }

  Widget products(List<Products> products) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 320, mainAxisSpacing: 18),
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: product(products[index]));
        },
        itemCount: products.length,
      ),
    );
  }

  Widget product(Products product) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    // color: MyTheme.blackColor,
                    color: Colors.black54,
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Image.network(
                  product.images![0],
                  height: 150,
                )),
            Positioned(
                top: 5,
                right: 5,
                child: icon(
                    icon: Icons.favorite_border,
                    iconColor: MyTheme.subColor,
                    backgroundColor: MyTheme.whiteColor)),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
          padding: EdgeInsets.all(6),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title!,
                  style: Theme.of(context).textTheme.headline2),
              price_add(
                  price: product.price!,
                  discountPercentage: product.discountPercentage!),
              rating(product.rating!),
            ],
          ),
        ),
      ],
    );
  }

  Widget icon(
      {required IconData icon,
      required Color iconColor,
      required Color backgroundColor}) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(18)),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
  Row price_add({required num price, required num discountPercentage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(price.toString(),
                style: Theme.of(context).textTheme.headline2),
            SizedBox(
              width: 2,
            ),
            Text(
                viewModel
                    .calculateOriginalPrice(
                        price.toDouble(), discountPercentage.toDouble())
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(decoration: TextDecoration.lineThrough)),
          ],
        ),
        icon(
            icon: Icons.add,
            iconColor: MyTheme.whiteColor,
            backgroundColor: MyTheme.subColor)
      ],
    );
  }
  Row rating(num rating) {
    return Row(children: [
      Text("Review ($rating)", style: Theme.of(context).textTheme.headline4),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          IconData icon;
          if (index < rating.floor()) {
            icon = Icons.star;
          } else if (index < rating && index >= rating.floor()) {
            icon = Icons.star_half;
          } else {
            icon = Icons.star_border;
          }
          return Icon(
            icon,
            size: 18,
            color: Colors.amberAccent,
          );
        }),
      ),
    ]);
  }

  @override
  HomeScreenViewModel initViewModel() {
    return HomeScreenViewModel();
  }

  @override
  void setStateScreen() {
    setState(() {});
  }
}
