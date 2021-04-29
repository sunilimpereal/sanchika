import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getAddresss_model.dart';
import 'package:sanchika/model/multiitemSaveOrder.dart';
import 'package:sanchika/model/myInformation.dart';

class ConvertCartToOrder{
  String paymentType;
  String userId;
  List<CartItem> cartItems;
  MyInformationClass myInformation;
  ShippingAddress address;
  ConvertCartToOrder({this.userId,this.cartItems,this.myInformation,this.address,this.paymentType});
  List<OrderItem> convert(){
    List<OrderItem> orderItems = [];
     orderItems = cartItems.map((a) {
       OrderItem orderItem = new OrderItem();
        orderItem.wohOrdDt = DateTime.now();
        orderItem.wohOrdTime = DateTime.now().toString();
        orderItem.wohInvcDt = DateTime.now();
        orderItem.wohOrdMod = "app";
        orderItem.wohUsrId = int.parse(userId);
        orderItem.wohUsrNm = myInformation.firstName;
        orderItem.wohPhNum = myInformation.mobile;
        orderItem.wohEmlId = myInformation.email;
        orderItem.wohCstType= "user";//TODO check this feild once
        orderItem.wohShpSt = address.state1;
        orderItem.wodDisAmt = 0;
        orderItem.wohPymTyp = paymentType;
        orderItem.wodPdtCtgy = "";
        orderItem.wodPdtId= a.productId;
        orderItem.wodPdtNm = a.productName;
        orderItem.wosdCty = address.city1;
        orderItem.wosdCy = "India";
        orderItem.wosdFsNm = myInformation.firstName;
        orderItem.wosdShipAds1 = address.asd1;
        orderItem.wohTotQnt = a.quantity;
        orderItem.wohMrp = a.mrp;
        orderItem.wohTotPrc = a.mrp*a.quantity;
        orderItem.wodPdtId = a.productId;
        orderItem.wosdPin = address.pin1;
     }).toList();
     return orderItems;
  }
}