// To parse this JSON data, do
//
//     final placedOrder = placedOrderFromJson(jsonString);

import 'dart:convert';

PlacedOrder placedOrderFromJson(String str) => PlacedOrder.fromJson(json.decode(str));

String placedOrderToJson(PlacedOrder data) => json.encode(data.toJson());

class PlacedOrder {
    PlacedOrder({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory PlacedOrder.fromJson(Map<String, dynamic> json) => PlacedOrder(
        status: json["status"],
        statusMsg: json["statusMsg"],
        errorCode: json["errorCode"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusMsg": statusMsg,
        "errorCode": errorCode,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.orderUserDetails,
    });

    Map<String, OrderUserDetails> orderUserDetails;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderUserDetails: Map.from(json["Order User  Details "]).map((k, v) => MapEntry<String, OrderUserDetails>(k, OrderUserDetails.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "Order User  Details ": Map.from(orderUserDetails).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class OrderUserDetails {
    OrderUserDetails({
        this.orderHeader,
        this.orderHeaderDetail,
        this.orderShippingDetail,
    });

    OrderHeader orderHeader;
    OrderHeaderDetail orderHeaderDetail;
    OrderShippingDetail orderShippingDetail;

    factory OrderUserDetails.fromJson(Map<String, dynamic> json) => OrderUserDetails(
        orderHeader: OrderHeader.fromJson(json["OrderHeader"]),
        orderHeaderDetail: OrderHeaderDetail.fromJson(json["OrderHeaderDetail"]),
        orderShippingDetail: OrderShippingDetail.fromJson(json["OrderShippingDetail"]),
    );

    Map<String, dynamic> toJson() => {
        "OrderHeader": orderHeader.toJson(),
        "OrderHeaderDetail": orderHeaderDetail.toJson(),
        "OrderShippingDetail": orderShippingDetail.toJson(),
    };
}

class OrderHeader {
    OrderHeader({
        this.wohId,
        this.wohCmyCd,
        this.wohStrCd,
        this.wohOrdNum,
        this.wohOrdDt,
        this.wohOrdTime,
        this.wohInvcNum,
        this.wohInvcDt,
        this.wohOrdMod,
        this.wohDvDt,
        this.wohUsrId,
        this.wohUsrNm,
        this.wohPhNum,
        this.wohEmlId,
        this.wohCstType,
        this.wohShpSt,
        this.wohAdmCmt,
        this.wohUsrCmt,
        this.wohTotQnt,
        this.wohTotItm,
        this.wohMrp,
        this.wohTotPrc,
        this.wohDisAmt,
        this.wohSubsAmt,
        this.wohTxAmt,
        this.wohGrndTot,
        this.wohShpChrg,
        this.wohNetAmt,
        this.wohPymTyp,
        this.wohPymMod,
        this.wohPymRecd,
        this.wohDelvryType,
        this.wohStatus,
        this.wohSycDtTm,
        this.wohCpnCd,
        this.wohCpnRedmd,
        this.wohTxId,
    });

    int wohId;
    String wohCmyCd;
    String wohStrCd;
    int wohOrdNum;
    DateTime wohOrdDt;
    String wohOrdTime;
    String wohInvcNum;
    DateTime wohInvcDt;
    String wohOrdMod;
    DateTime wohDvDt;
    int wohUsrId;
    String wohUsrNm;
    String wohPhNum;
    String wohEmlId;
    String wohCstType;
    String wohShpSt;
    String wohAdmCmt;
    String wohUsrCmt;
    String wohTotQnt;
    String wohTotItm;
    int wohMrp;
    int wohTotPrc;
    int wohDisAmt;
    int wohSubsAmt;
    int wohTxAmt;
    int wohGrndTot;
    int wohShpChrg;
    int wohNetAmt;
    String wohPymTyp;
    String wohPymMod;
    String wohPymRecd;
    String wohDelvryType;
    String wohStatus;
    dynamic wohSycDtTm;
    String wohCpnCd;
    String wohCpnRedmd;
    dynamic wohTxId;

    factory OrderHeader.fromJson(Map<String, dynamic> json) => OrderHeader(
        wohId: json["woh_id"],
        wohCmyCd: json["woh_cmy_cd"],
        wohStrCd: json["woh_str_cd"],
        wohOrdNum: json["woh_ord_num"],
        wohOrdDt: DateTime.parse(json["woh_ord_dt"]),
        wohOrdTime: json["woh_ord_time"],
        wohInvcNum: json["woh_invc_num"],
        wohInvcDt: DateTime.parse(json["woh_invc_dt"]),
        wohOrdMod: json["woh_ord_mod"],
        wohDvDt: DateTime.parse(json["woh_dv_dt"]),
        wohUsrId: json["woh_usr_id"],
        wohUsrNm: json["woh_usr_nm"],
        wohPhNum: json["woh_ph_num"],
        wohEmlId: json["woh_eml_id"],
        wohCstType: json["woh_cst_type"],
        wohShpSt: json["woh_shp_st"],
        wohAdmCmt: json["woh_adm_cmt"],
        wohUsrCmt: json["woh_usr_cmt"],
        wohTotQnt: json["woh_tot_qnt"],
        wohTotItm: json["woh_tot_itm"],
        wohMrp: json["woh_mrp"],
        wohTotPrc: json["woh_tot_prc"],
        wohDisAmt: json["woh_dis_amt"],
        wohSubsAmt: json["woh_subs_amt"],
        wohTxAmt: json["woh_tx_amt"],
        wohGrndTot: json["woh_grnd_tot"],
        wohShpChrg: json["woh_shp_chrg"],
        wohNetAmt: json["woh_net_amt"],
        wohPymTyp: json["woh_pym_typ"],
        wohPymMod: json["woh_pym_mod"],
        wohPymRecd: json["woh_pym_recd"],
        wohDelvryType: json["woh_delvry_type"],
        wohStatus: json["woh_status"],
        wohSycDtTm: json["woh_syc_dt_tm"],
        wohCpnCd: json["woh_cpn_cd"],
        wohCpnRedmd: json["woh_cpn_redmd"],
        wohTxId: json["woh_tx_id"],
    );

    Map<String, dynamic> toJson() => {
        "woh_id": wohId,
        "woh_cmy_cd": wohCmyCd,
        "woh_str_cd": wohStrCd,
        "woh_ord_num": wohOrdNum,
        "woh_ord_dt": "${wohOrdDt.year.toString().padLeft(4, '0')}-${wohOrdDt.month.toString().padLeft(2, '0')}-${wohOrdDt.day.toString().padLeft(2, '0')}",
        "woh_ord_time": wohOrdTime,
        "woh_invc_num": wohInvcNum,
        "woh_invc_dt": "${wohInvcDt.year.toString().padLeft(4, '0')}-${wohInvcDt.month.toString().padLeft(2, '0')}-${wohInvcDt.day.toString().padLeft(2, '0')}",
        "woh_ord_mod": wohOrdMod,
        "woh_dv_dt": "${wohDvDt.year.toString().padLeft(4, '0')}-${wohDvDt.month.toString().padLeft(2, '0')}-${wohDvDt.day.toString().padLeft(2, '0')}",
        "woh_usr_id": wohUsrId,
        "woh_usr_nm": wohUsrNm,
        "woh_ph_num": wohPhNum,
        "woh_eml_id": wohEmlId,
        "woh_cst_type": wohCstType,
        "woh_shp_st": wohShpSt,
        "woh_adm_cmt": wohAdmCmt,
        "woh_usr_cmt": wohUsrCmt,
        "woh_tot_qnt": wohTotQnt,
        "woh_tot_itm": wohTotItm,
        "woh_mrp": wohMrp,
        "woh_tot_prc": wohTotPrc,
        "woh_dis_amt": wohDisAmt,
        "woh_subs_amt": wohSubsAmt,
        "woh_tx_amt": wohTxAmt,
        "woh_grnd_tot": wohGrndTot,
        "woh_shp_chrg": wohShpChrg,
        "woh_net_amt": wohNetAmt,
        "woh_pym_typ": wohPymTyp,
        "woh_pym_mod": wohPymMod,
        "woh_pym_recd": wohPymRecd,
        "woh_delvry_type": wohDelvryType,
        "woh_status": wohStatus,
        "woh_syc_dt_tm": wohSycDtTm,
        "woh_cpn_cd": wohCpnCd,
        "woh_cpn_redmd": wohCpnRedmd,
        "woh_tx_id": wohTxId,
    };
}

class OrderHeaderDetail {
    OrderHeaderDetail({
        this.wodId,
        this.wodCmyCd,
        this.wodStrCd,
        this.wodOrdDt,
        this.wodDvDt,
        this.wodOrdNum,
        this.wodGrndTot,
        this.wodIsDltd,
        this.wodItmTotWeght,
        this.wodItmWeght,
        this.wodOrdSchdDt,
        this.wodPdtCtgy,
        this.wodPdtId,
        this.wodPdtNm,
        this.wodSlId,
        this.wodQty,
        this.wodMrp,
        this.wodSlPrc,
        this.wodDisAmt,
        this.wodSubsAmt,
        this.wodSts,
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
        this.wodUsrId,
        this.wodTxId,
    });

    int wodId;
    String wodCmyCd;
    String wodStrCd;
    DateTime wodOrdDt;
    DateTime wodDvDt;
    int wodOrdNum;
    int wodGrndTot;
    String wodIsDltd;
    String wodItmTotWeght;
    String wodItmWeght;
    String wodOrdSchdDt;
    String wodPdtCtgy;
    String wodPdtId;
    String wodPdtNm;
    String wodSlId;
    String wodQty;
    int wodMrp;
    int wodSlPrc;
    int wodDisAmt;
    int wodSubsAmt;
    String wodSts;
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
    dynamic wodUsrId;
    dynamic wodTxId;

    factory OrderHeaderDetail.fromJson(Map<String, dynamic> json) => OrderHeaderDetail(
        wodId: json["wod_id"],
        wodCmyCd: json["wod_cmy_cd"],
        wodStrCd: json["wod_str_cd"],
        wodOrdDt: DateTime.parse(json["wod_ord_dt"]),
        wodDvDt: DateTime.parse(json["wod_dv_dt"]),
        wodOrdNum: json["wod_ord_num"],
        wodGrndTot: json["wod_grnd_tot"],
        wodIsDltd: json["wod_is_dltd"],
        wodItmTotWeght: json["wod_itm_tot_weght"],
        wodItmWeght: json["wod_itm_weght"],
        wodOrdSchdDt: json["wod_ord_schd_dt"],
        wodPdtCtgy: json["wod_pdt_ctgy"],
        wodPdtId: json["wod_pdt_id"],
        wodPdtNm: json["wod_pdt_nm"],
        wodSlId: json["wod_sl_id"],
        wodQty: json["wod_qty"],
        wodMrp: json["wod_mrp"],
        wodSlPrc: json["wod_sl_prc"],
        wodDisAmt: json["wod_dis_amt"],
        wodSubsAmt: json["wod_subs_amt"],
        wodSts: json["wod_sts"],
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
        wodUsrId: json["wod_usr_id"],
        wodTxId: json["wod_tx_id"],
    );

    Map<String, dynamic> toJson() => {
        "wod_id": wodId,
        "wod_cmy_cd": wodCmyCd,
        "wod_str_cd": wodStrCd,
        "wod_ord_dt": "${wodOrdDt.year.toString().padLeft(4, '0')}-${wodOrdDt.month.toString().padLeft(2, '0')}-${wodOrdDt.day.toString().padLeft(2, '0')}",
        "wod_dv_dt": "${wodDvDt.year.toString().padLeft(4, '0')}-${wodDvDt.month.toString().padLeft(2, '0')}-${wodDvDt.day.toString().padLeft(2, '0')}",
        "wod_ord_num": wodOrdNum,
        "wod_grnd_tot": wodGrndTot,
        "wod_is_dltd": wodIsDltd,
        "wod_itm_tot_weght": wodItmTotWeght,
        "wod_itm_weght": wodItmWeght,
        "wod_ord_schd_dt": wodOrdSchdDt,
        "wod_pdt_ctgy": wodPdtCtgy,
        "wod_pdt_id": wodPdtId,
        "wod_pdt_nm": wodPdtNm,
        "wod_sl_id": wodSlId,
        "wod_qty": wodQty,
        "wod_mrp": wodMrp,
        "wod_sl_prc": wodSlPrc,
        "wod_dis_amt": wodDisAmt,
        "wod_subs_amt": wodSubsAmt,
        "wod_sts": wodSts,
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
        "wod_usr_id": wodUsrId,
        "wod_tx_id": wodTxId,
    };
}

class OrderShippingDetail {
    OrderShippingDetail({
        this.wosdId,
        this.wosdOrdNum,
        this.wosdCmyCd,
        this.wosdOrdDt,
        this.wosdCty,
        this.wosdCy,
        this.wosdEmlAds,
        this.wosdFsNm,
        this.wosdGnd,
        this.wosdIsDltd,
        this.wosdLcly,
        this.wosdLndMrk,
        this.wosdLsNm,
        this.wosdPhNum,
        this.wosdPin,
        this.wosdPrnAds,
        this.wosdShipAds1,
        this.wosdShipAds2,
        this.wosdSt,
        this.wosdSts,
        this.wosdUpdtDt,
        this.wosdUsrId,
        this.wosdUsrNm,
        this.wosdAddType,
        this.wosdSycDtTm,
        this.wosdTxId,
    });

    int wosdId;
    int wosdOrdNum;
    String wosdCmyCd;
    DateTime wosdOrdDt;
    String wosdCty;
    String wosdCy;
    String wosdEmlAds;
    String wosdFsNm;
    String wosdGnd;
    bool wosdIsDltd;
    String wosdLcly;
    String wosdLndMrk;
    String wosdLsNm;
    String wosdPhNum;
    String wosdPin;
    String wosdPrnAds;
    String wosdShipAds1;
    String wosdShipAds2;
    String wosdSt;
    String wosdSts;
    String wosdUpdtDt;
    int wosdUsrId;
    String wosdUsrNm;
    String wosdAddType;
    String wosdSycDtTm;
    dynamic wosdTxId;

    factory OrderShippingDetail.fromJson(Map<String, dynamic> json) => OrderShippingDetail(
        wosdId: json["wosd_id"],
        wosdOrdNum: json["wosd_ord_num"],
        wosdCmyCd: json["wosd_cmy_cd"],
        wosdOrdDt: DateTime.parse(json["wosd_ord_dt"]),
        wosdCty: json["wosd_cty"],
        wosdCy: json["wosd_cy"],
        wosdEmlAds: json["wosd_eml_ads"],
        wosdFsNm: json["wosd_fs_nm"],
        wosdGnd: json["wosd_gnd"],
        wosdIsDltd: json["wosd_is_dltd"],
        wosdLcly: json["wosd_lcly"],
        wosdLndMrk: json["wosd_lnd_mrk"],
        wosdLsNm: json["wosd_ls_nm"],
        wosdPhNum: json["wosd_ph_num"],
        wosdPin: json["wosd_pin"],
        wosdPrnAds: json["wosd_prn_ads"],
        wosdShipAds1: json["wosd_ship_ads1"],
        wosdShipAds2: json["wosd_ship_ads2"],
        wosdSt: json["wosd_st"],
        wosdSts: json["wosd_sts"],
        wosdUpdtDt: json["wosd_updt_dt"],
        wosdUsrId: json["wosd_usr_id"],
        wosdUsrNm: json["wosd_usr_nm"],
        wosdAddType: json["wosd_add_type"],
        wosdSycDtTm: json["wosd_syc_dt_tm"],
        wosdTxId: json["wosd_tx_id"],
    );

    Map<String, dynamic> toJson() => {
        "wosd_id": wosdId,
        "wosd_ord_num": wosdOrdNum,
        "wosd_cmy_cd": wosdCmyCd,
        "wosd_ord_dt": "${wosdOrdDt.year.toString().padLeft(4, '0')}-${wosdOrdDt.month.toString().padLeft(2, '0')}-${wosdOrdDt.day.toString().padLeft(2, '0')}",
        "wosd_cty": wosdCty,
        "wosd_cy": wosdCy,
        "wosd_eml_ads": wosdEmlAds,
        "wosd_fs_nm": wosdFsNm,
        "wosd_gnd": wosdGnd,
        "wosd_is_dltd": wosdIsDltd,
        "wosd_lcly": wosdLcly,
        "wosd_lnd_mrk": wosdLndMrk,
        "wosd_ls_nm": wosdLsNm,
        "wosd_ph_num": wosdPhNum,
        "wosd_pin": wosdPin,
        "wosd_prn_ads": wosdPrnAds,
        "wosd_ship_ads1": wosdShipAds1,
        "wosd_ship_ads2": wosdShipAds2,
        "wosd_st": wosdSt,
        "wosd_sts": wosdSts,
        "wosd_updt_dt": wosdUpdtDt,
        "wosd_usr_id": wosdUsrId,
        "wosd_usr_nm": wosdUsrNm,
        "wosd_add_type": wosdAddType,
        "wosd_syc_dt_tm": wosdSycDtTm,
        "wosd_tx_id": wosdTxId,
    };
}
