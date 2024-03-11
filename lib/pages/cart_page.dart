import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_with_tgbot/stores/cart_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Cartcontroller controller = Get.put(Cartcontroller());

  @override
  void initState() {
    controller.fetchCartProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Cartcontroller>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Basket"),

            ),
            bottomNavigationBar:
            controller.cartProducts.isEmpty?const SizedBox():
             Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child:  Column(
            mainAxisSize:MainAxisSize.min,
                children: [
                   Text("The overall price: ${controller.totalPrice()} dollars"),
                  ElevatedButton(onPressed: (){
                    controller.ordered();
                  }, child: Text("Order"))
                ],
              )
            ),
            body: ListView.builder(
                itemCount: controller.cartProducts.length,
                itemBuilder: (context, index) {
                  var item = controller.cartProducts[index];
                  return CartProduct(
                    title: item['title'],
                    price: item['price'],
                    count: item['count'],
                    add: () {
                      controller.add(item['id']);
                    },
                    remove: () {
                      controller.remove(item['id']);
                    },
                  );
                }));
      },
    );
  }
}

class CartProduct extends StatelessWidget {
      CartProduct({
    super.key,
    required this.count,
    required this.price,
    required this.title,
    required this.add,
    required this.remove,
  });
  final String title;
  final int price;
  final int count;
  Function add;
  Function remove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: price.toString(),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: " dollars")
                ])),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  remove();
                },
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                )),
            Text(count.toString()),
            IconButton(
                onPressed: () { add();},
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.green,
                )),
          ],
        ),
      ),
    );
  }
}
