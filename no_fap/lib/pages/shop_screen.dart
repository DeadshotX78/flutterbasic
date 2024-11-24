import 'package:flutter/material.dart';
import 'package:no_fap/components/coffee_tile.dart';
import 'package:no_fap/models/coffee.dart';
import 'package:no_fap/models/shop.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  //add to cart
  void addItemToCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).addtoCart(coffee);
    //let user know order has been added
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Center(
          child: Text(
            "Added To Cart✅",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Text(
                "What would you like today?",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 25),
              //list of coffees
              Expanded(
                child: ListView.builder(
                  itemCount: value.coffeeShop.length,
                  itemBuilder: (context, index) {
                    //getindividual coffee
                    Coffee eachCoffee = value.coffeeShop[index];
                    //return coffee UI tile
                    return CoffeeTile(
                      icon: const Icon(Icons.add),
                      coffee: eachCoffee,
                      onPressed: () => addItemToCart(eachCoffee),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
