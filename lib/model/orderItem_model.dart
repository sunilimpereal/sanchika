// To parse this JSON data, do
//
//     final orderItemList = orderItemListFromJson(jsonString);

//pending

import 'dart:convert';

List<OrderItem> orderItemListFromJson(String str) => List<OrderItem>.from(json.decode(str).map((x) => OrderItem.fromJson(x)));

String orderItemListToJson(List<OrderItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderItem {
    OrderItem({
        this.companyCode,
        this.storeCode,
        this.orderDate,
        this.ordeeTime,
        this.orderInvoiceNumber,
        this.orderInvoiceDate,
        this.ordermode,
        this.orderDeliverydate,
        this.userId,
        this.userName,
        this.phoneNumber,
        this.email,
        this.customerType,
        this.orderShppingState,
        this.adminComment,
        this.userComment,
        this.totalQuantity,
        this.totalItem,
        this.totalPrice,
        this.discountAmount,
        this.subsAmount,
        this.taxAmount,
        this.grandTotal,
        this.shppingCharge,
        this.netAmount,
        this.paymentType,
        this.paymentMode,
        this.paymentRecieved,
        this.deliveryType,
        this.orderStatus,
        this.orderSyncDateTime,
        this.orderCuponCode,
        this.cuponRedeemed,
        this.ordtlIsDltd,
        this.wodItmTotWeght,
        this.wodItmWeght,
        this.wodOrdSchdDt,
        this.wodPdtCtgy,
        this.wodPdtId,
        this.wodPdtNm,
        this.wodSlId,
        this.wodQty,
        this.wodSlPrc,
        this.wodDisAmt,
        this.wodSubsAmt,
        this.wodSts,
        this.wodIsDltd,
        this.wodSubsCd,
        this.wodSubsRedmd,
        this.wodSz,
        this.wodTotPrc,
        this.wodTxCd,
        this.wodCgstPer,
        this.wodCgstAmt,
        this.wodSgstPer,
        this.wodSgstAmt,
        this.wodIgstPer,
        this.wodIgstAmt,
        this.wodCessPer,
        this.wodCessAmt,
        this.wodKfcPer,
        this.wodKfcAmt,
        this.wodTotTxAmt,
        this.wodSycDtTm,
        this.wodShpChg,
        this.wodNetAmt,
        this.wosdCty,
        this.wosdCy,
        this.wosdFsNm,
        this.wosdGnd,
        this.wosdIsDltd,
        this.wosdLcly,
        this.wosdLndMrk,
        this.wosdLsNm,
        this.wosdPin,
        this.wosdPrnAds,
        this.wosdShipAds1,
        this.wosdShipAds2,
        this.wosdSt,
        this.wosdSts,
        this.wosdUpdtDt,
        this.wosdAddType,
        this.wosdSycDtTm,
    });

    String companyCode;
    String storeCode;
    String orderDate;
    String ordeeTime;
    String orderInvoiceNumber;
    String orderInvoiceDate;
    String ordermode;
    String orderDeliverydate;
    String userId;
    String userName;
    String phoneNumber;
    String email;
    String customerType;
    String orderShppingState;
    String adminComment;
    String userComment;
    String totalQuantity;
    String totalItem;
    int totalPrice;
    int discountAmount;
    int subsAmount;
    double taxAmount;
    int grandTotal;
    int shppingCharge;
    int netAmount;
    String paymentType;
    String paymentMode;
    String paymentRecieved;
    String deliveryType;
    String orderStatus;
    String orderSyncDateTime;
    String orderCuponCode;
    String cuponRedeemed;
    bool ordtlIsDltd;
    String wodItmTotWeght;
    String wodItmWeght;
    String wodOrdSchdDt;
    String wodPdtCtgy;
    String wodPdtId;
    String wodPdtNm;
    String wodSlId;
    String wodQty;
    int wodSlPrc;
    int wodDisAmt;
    int wodSubsAmt;
    String wodSts;
    int wodIsDltd;
    String wodSubsCd;
    String wodSubsRedmd;
    String wodSz;
    int wodTotPrc;
    int wodTxCd;
    double wodCgstPer;
    double wodCgstAmt;
    double wodSgstPer;
    double wodSgstAmt;
    double wodIgstPer;
    double wodIgstAmt;
    double wodCessPer;
    double wodCessAmt;
    double wodKfcPer;
    double wodKfcAmt;
    int wodTotTxAmt;
    String wodSycDtTm;
    int wodShpChg;
    int wodNetAmt;
    String wosdCty;
    String wosdCy;
    String wosdFsNm;
    String wosdGnd;
    bool wosdIsDltd;
    String wosdLcly;
    String wosdLndMrk;
    String wosdLsNm;
    String wosdPin;
    String wosdPrnAds;
    String wosdShipAds1;
    String wosdShipAds2;
    String wosdSt;
    String wosdSts;
    String wosdUpdtDt;
    String wosdAddType;
    String wosdSycDtTm;

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        companyCode: json["companyCode"],
        storeCode: json["storeCode"],
        orderDate: json["orderDate"],
        ordeeTime: json["ordeeTime"],
        orderInvoiceNumber: json["OrderInvoiceNumber"],
        orderInvoiceDate: json["orderInvoiceDate"],
        ordermode: json["ordermode"],
        orderDeliverydate: json["orderDeliverydate"],
        userId: json["userId"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        customerType: json["customerType"],
        orderShppingState: json["orderShppingState"],
        adminComment: json["adminComment"],
        userComment: json["userComment"],
        totalQuantity: json["totalQuantity"],
        totalItem: json["totalItem"],
        totalPrice: json["totalPrice"],
        discountAmount: json["discountAmount"],
        subsAmount: json["subsAmount"],
        taxAmount: json["taxAmount"].toDouble(),
        grandTotal: json["grandTotal"],
        shppingCharge: json["shppingCharge"],
        netAmount: json["netAmount"],
        paymentType: json["paymentType"],
        paymentMode: json["paymentMode"],
        paymentRecieved: json["paymentRecieved"],
        deliveryType: json["deliveryType"],
        orderStatus: json["orderStatus"],
        orderSyncDateTime: json["orderSyncDateTime"],
        orderCuponCode: json["orderCuponCode"],
        cuponRedeemed: json["cuponRedeemed"],
        ordtlIsDltd: json["ordtl_is_dltd"],
        wodItmTotWeght: json["wod_itm_tot_weght"],
        wodItmWeght: json["wod_itm_weght"],
        wodOrdSchdDt: json["wod_ord_schd_dt"],
        wodPdtCtgy: json["wod_pdt_ctgy"],
        wodPdtId: json["wod_pdt_id"],
        wodPdtNm: json["wod_pdt_nm"],
        wodSlId: json["wod_sl_id"],
        wodQty: json["wod_qty"],
        wodSlPrc: json["wod_sl_prc"],
        wodDisAmt: json["wod_dis_amt"],
        wodSubsAmt: json["wod_subs_amt"],
        wodSts: json["wod_sts"],
        wodIsDltd: json["wod_is_dltd"],
        wodSubsCd: json["wod_subs_cd"],
        wodSubsRedmd: json["wod_subs_redmd"],
        wodSz: json["wod_sz"],
        wodTotPrc: json["wod_tot_prc"],
        wodTxCd: json["wod_tx_cd"],
        wodCgstPer: json["wod_cgst_Per"].toDouble(),
        wodCgstAmt: json["wod_cgst_amt"].toDouble(),
        wodSgstPer: json["wod_sgst_Per"].toDouble(),
        wodSgstAmt: json["wod_sgst_amt"].toDouble(),
        wodIgstPer: json["wod_igst_Per"].toDouble(),
        wodIgstAmt: json["wod_igst_amt"].toDouble(),
        wodCessPer: json["wod_cess_Per"].toDouble(),
        wodCessAmt: json["wod_cess_amt"].toDouble(),
        wodKfcPer: json["wod_kfc_Per"].toDouble(),
        wodKfcAmt: json["wod_kfc_amt"].toDouble(),
        wodTotTxAmt: json["wod_tot_tx_amt"],
        wodSycDtTm: json["wod_syc_dt_tm"],
        wodShpChg: json["wod_shp_chg"],
        wodNetAmt: json["wod_net_amt"],
        wosdCty: json["wosd_cty"],
        wosdCy: json["wosd_cy"],
        wosdFsNm: json["wosd_fs_nm"],
        wosdGnd: json["wosd_gnd"],
        wosdIsDltd: json["wosd_is_dltd"],
        wosdLcly: json["wosd_lcly"],
        wosdLndMrk: json["wosd_lnd_mrk"],
        wosdLsNm: json["wosd_ls_nm"],
        wosdPin: json["wosd_pin"],
        wosdPrnAds: json["wosd_prn_ads"],
        wosdShipAds1: json["wosd_ship_ads1"],
        wosdShipAds2: json["wosd_ship_ads2"],
        wosdSt: json["wosd_st"],
        wosdSts: json["wosd_sts"],
        wosdUpdtDt: json["wosd_updt_dt"],
        wosdAddType: json["wosd_add_type"],
        wosdSycDtTm: json["wosd_syc_dt_tm"],
    );

    Map<String, dynamic> toJson() => {
        "companyCode": companyCode,
        "storeCode": storeCode,
        "orderDate": orderDate,
        "ordeeTime": ordeeTime,
        "OrderInvoiceNumber": orderInvoiceNumber,
        "orderInvoiceDate": orderInvoiceDate,
        "ordermode": ordermode,
        "orderDeliverydate": orderDeliverydate,
        "userId": userId,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "email": email,
        "customerType": customerType,
        "orderShppingState": orderShppingState,
        "adminComment": adminComment,
        "userComment": userComment,
        "totalQuantity": totalQuantity,
        "totalItem": totalItem,
        "totalPrice": totalPrice,
        "discountAmount": discountAmount,
        "subsAmount": subsAmount,
        "taxAmount": taxAmount,
        "grandTotal": grandTotal,
        "shppingCharge": shppingCharge,
        "netAmount": netAmount,
        "paymentType": paymentType,
        "paymentMode": paymentMode,
        "paymentRecieved": paymentRecieved,
        "deliveryType": deliveryType,
        "orderStatus": orderStatus,
        "orderSyncDateTime": orderSyncDateTime,
        "orderCuponCode": orderCuponCode,
        "cuponRedeemed": cuponRedeemed,
        "ordtl_is_dltd": ordtlIsDltd,
        "wod_itm_tot_weght": wodItmTotWeght,
        "wod_itm_weght": wodItmWeght,
        "wod_ord_schd_dt": wodOrdSchdDt,
        "wod_pdt_ctgy": wodPdtCtgy,
        "wod_pdt_id": wodPdtId,
        "wod_pdt_nm": wodPdtNm,
        "wod_sl_id": wodSlId,
        "wod_qty": wodQty,
        "wod_sl_prc": wodSlPrc,
        "wod_dis_amt": wodDisAmt,
        "wod_subs_amt": wodSubsAmt,
        "wod_sts": wodSts,
        "wod_is_dltd": wodIsDltd,
        "wod_subs_cd": wodSubsCd,
        "wod_subs_redmd": wodSubsRedmd,
        "wod_sz": wodSz,
        "wod_tot_prc": wodTotPrc,
        "wod_tx_cd": wodTxCd,
        "wod_cgst_Per": wodCgstPer,
        "wod_cgst_amt": wodCgstAmt,
        "wod_sgst_Per": wodSgstPer,
        "wod_sgst_amt": wodSgstAmt,
        "wod_igst_Per": wodIgstPer,
        "wod_igst_amt": wodIgstAmt,
        "wod_cess_Per": wodCessPer,
        "wod_cess_amt": wodCessAmt,
        "wod_kfc_Per": wodKfcPer,
        "wod_kfc_amt": wodKfcAmt,
        "wod_tot_tx_amt": wodTotTxAmt,
        "wod_syc_dt_tm": wodSycDtTm,
        "wod_shp_chg": wodShpChg,
        "wod_net_amt": wodNetAmt,
        "wosd_cty": wosdCty,
        "wosd_cy": wosdCy,
        "wosd_fs_nm": wosdFsNm,
        "wosd_gnd": wosdGnd,
        "wosd_is_dltd": wosdIsDltd,
        "wosd_lcly": wosdLcly,
        "wosd_lnd_mrk": wosdLndMrk,
        "wosd_ls_nm": wosdLsNm,
        "wosd_pin": wosdPin,
        "wosd_prn_ads": wosdPrnAds,
        "wosd_ship_ads1": wosdShipAds1,
        "wosd_ship_ads2": wosdShipAds2,
        "wosd_st": wosdSt,
        "wosd_sts": wosdSts,
        "wosd_updt_dt": wosdUpdtDt,
        "wosd_add_type": wosdAddType,
        "wosd_syc_dt_tm": wosdSycDtTm,
    };
}
