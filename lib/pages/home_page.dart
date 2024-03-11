import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app_with_tgbot/model/products_model.dart';
import 'package:shopping_app_with_tgbot/pages/cart_page.dart';
import 'package:shopping_app_with_tgbot/stores/product_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Map user = GetStorage().read('user');
ProductController controller = Get.put(ProductController());

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['name']),
        actions: [
          IconButton(onPressed: () {
            Get.to(()=>const CartPage());
          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            var item = controller.products[index];
            return ProductItem(
                item: item,
                onTap: () {
                  controller.add(item);
                });
          }),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductItem({super.key, required this.item, required this.onTap});
  ProductModel item;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  item.price.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                    onPressed: () {
                      onTap();
                    },
                    icon: Icon(
                      Icons.add_circle_outlined,
                      color: Colors.green,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
