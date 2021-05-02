import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getShippingDetail.dart';
import 'package:sanchika/model/multiitemSaveOrder.dart';

class ConvertCartToOrder{
  String paymentType;
  String userId;
  List<CartItem> cartItems;
  ShippingAddress address;
  ConvertCartToOrder({this.userId,this.cartItems,this.address,this.paymentType});
  List<OrderItem> convert({  ShippingAddress address,  List<CartItem> cartItems,}){
    List<OrderItem> orderItems = [];
     orderItems = cartItems.map((a) {
       OrderItem orderItem = new OrderItem();
        // orderItem.wohOrdDt = DateTime.now();
        // orderItem.wohOrdTime = DateTime.now().toString();
        // orderItem.wohInvcDt = DateTime.now();
        // orderItem.wohDvDt = DateTime.now();
        orderItem.wohOrdMod = "app";
        orderItem.wohUsrId = address.userId;
        orderItem.wohUsrNm = address.firstName;
        orderItem.wohPhNum = address.mobile;
        orderItem.wohEmlId = address.email;
        orderItem.wohCstType= "user";//TODO check this feild once
        orderItem.wohShpSt = address.state1;
        orderItem.wodDisAmt = 0;
        orderItem.wohPymTyp = paymentType;
        orderItem.wodPdtCtgy = "";
        orderItem.wodPdtId= a.productId;
        orderItem.wodPdtNm = a.productName;
        orderItem.wosdCty = address.city1;
        orderItem.wosdCy = "India";
        orderItem.wosdFsNm = address.firstName;
        orderItem.wosdShipAds1 = address.asd1;
        orderItem.wohTotQnt = a.quantity;
        orderItem.wohMrp = a.mrp??'0';
        orderItem.wohTotPrc = a.mrp*a.quantity;
        orderItem.wodPdtId = a.productId;
        orderItem.wosdPin = address.pin1;
        return orderItem;
     }).toList();
     return orderItems;
  }
}