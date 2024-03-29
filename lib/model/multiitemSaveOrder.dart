// To parse this JSON data, do
//
//     final orderItem = orderItemFromJson(jsonString);

import 'dart:convert';

List<OrderItem> orderItemFromJson(String str) => List<OrderItem>.from(json.decode(str).map((x) => OrderItem.fromJson(x)));

String orderItemToJson(List<OrderItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderItem {
    OrderItem({
        this.wohCmyCd,
        this.wohStrCd,
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

    String wohCmyCd;
    String wohStrCd;
    DateTime wohOrdDt;
    String wohOrdTime;
    int wohInvcNum;
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
    int wohTotQnt;
    int wohTotItm;
    double wohMrp;
    double wohTotPrc;
    double wohDisAmt;
    double wohSubsAmt;
    double wohTxAmt;
    double wohGrndTot;
    double wohShpChrg;
    double wohNetAmt;
    String wohPymTyp;
    String wohPymMod;
    String wohPymRecd;
    String wohDelvryType;
    String wohStatus;
    dynamic wohSycDtTm;
    String wohCpnCd;
    String wohCpnRedmd;
    dynamic wohTxId;
    String ordtlIsDltd;
    String wodItmTotWeght;
    String wodItmWeght;
    String wodOrdSchdDt;
    String wodPdtCtgy;
    String wodPdtId;
    String wodPdtNm;
    String wodSlId;
    String wodQty;
    double wodSlPrc;
    double wodDisAmt;
    String wodSubsAmt;
    String wodSts;
    String wodIsDltd;
    String wodSubsCd;
    String wodSubsRedmd;
    String wodSz;
    String wodTotPrc;
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
        wohCmyCd: json["woh_cmy_cd"],
        wohStrCd: json["woh_str_cd"],
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
        "woh_cmy_cd": wohCmyCd,
        "woh_str_cd": wohStrCd,
        "woh_ord_dt": wohOrdDt,
        "woh_ord_time": wohOrdTime,
        "woh_invc_num": wohInvcNum,
        "woh_invc_dt": wohInvcDt,
        "woh_ord_mod": wohOrdMod,
        "woh_dv_dt": wohDvDt,
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
