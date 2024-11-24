import 'package:flutter/material.dart';
import 'package:no_fap/models/coffee.dart';

class CoffeeShop extends ChangeNotifier {
  //coffee list
  final List<Coffee> _shop = [
    //latte
    Coffee(
      name: "Black Flat",
      price: "5.50",
      imgPath: 'lib/assets/images/hot-coffee.png',
    ),
    //espresso
    Coffee(
      name: "Flash Express",
      price: "8.50",
      imgPath: 'lib/assets/images/coffee-latte.png',
    ),

    //iced
    Coffee(
      imgPath: 'lib/assets/images/coffee-cup.png',
      name: "Iced Latte",
      price: "4.00",
    ),

    //pumpkin
    Coffee(
      imgPath: 'lib/assets/images/coffee-cup.png',
      name: "Spicy Pumpkin Latte",
      price: "8.00",
    ),

    //Fratticino
    Coffee(
      imgPath: 'lib/assets/images/coffee-cup.png',
      name: "Fratticino",
      price: "4.50",
    ),
  ];
  //user cart
  final List<Coffee> _cart = [];
  //get list
  List<Coffee> get coffeeShop => _shop;
  //get user cart
  List<Coffee> get coffeeCart => _cart;
  //add to cart
  void addtoCart(Coffee coffee) {
    _cart.add(coffee);
    notifyListeners();
  }

  //remove from cart
  void removefromCart(Coffee coffee) {
    _cart.remove(coffee);
    notifyListeners();
  }
}
