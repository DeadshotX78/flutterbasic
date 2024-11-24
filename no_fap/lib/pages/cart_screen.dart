import 'package:flutter/material.dart';
import 'package:no_fap/components/button.dart';
import 'package:no_fap/components/coffee_tile.dart';
import 'package:no_fap/constants.dart';
import 'package:no_fap/models/coffee.dart';
import 'package:no_fap/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //delete from cart
  void removeItemFromCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).removefromCart(coffee);
  }

  //payment
  void payNow() {
    //add GPay functionality
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Cart',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 25),
              //list of cart items
              Expanded(
                child: ListView.builder(
                  itemCount: value.coffeeCart.length,
                  itemBuilder: (context, index) {
                    //get individual cart items
                    Coffee eachCoffee = value.coffeeCart[index];
                    //return tile UI
                    return CoffeeTile(
                      coffee: eachCoffee,
                      onPressed: () => removeItemFromCart(eachCoffee),
                      icon: const Icon(Icons.delete_rounded),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              //pay button
              MyButton(
                onTap: payNow,
                text: "Pay Now 💵 💳",
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: backgroundColor,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or Continue With",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //gpay button
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.asset(
                      'lib/assets/images/google-pay.png',
                      height: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
