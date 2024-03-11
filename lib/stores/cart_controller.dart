import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Cartcontroller extends GetxController{
  GetStorage base = GetStorage();

  List cartProducts=[];

  fetchCartProducts(){
    cartProducts=base.read('cart-product');
update();
  }

  updateBase(){
    base.write('cart-product', cartProducts);
  }


  add(int id){
    var index = cartProducts.indexWhere((el) => el['id']==id);
    if(index > -1){
      cartProducts[index]['count']++;
      fetchCartProducts();
  updateBase();
    }
  }


  remove(int id){
    var index = cartProducts.indexWhere((el) => el['id']==id);
    if(index>-1){

      if(cartProducts[index]['count']==1){
        cartProducts.removeAt(index);

      }else{
      cartProducts[index]['count']--;

      }
      fetchCartProducts();
  updateBase();

    }

   
  }
  int totalPrice(){
    int price = 0;
    for (var el in cartProducts) { 
      price=el['price']*el['count'];
    }
    return price;
  }

  
// 6722420753:AAGR2nFACOo4_1htsj0KmNntpVR5ihmwmYE

  Dio dio =Dio();
  ordered()async{
    
    var token = '6722420753:AAGR2nFACOo4_1htsj0KmNntpVR5ihmwmYE';
    try{
       await dio.post('https://api.telegram.org/bot$token/sendMessage?chat_id=5785701092&text=$cartProducts');
    base.remove('cart-product');
    fetchCartProducts();

    }catch(err){
      print(err);
    }
   
  }
}