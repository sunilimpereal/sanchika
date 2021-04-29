
class Product {
    Product({
        this.pdmId,
        this.pdmPdtId,
        this.pdmAcv,
        this.stmCurrStkQty,
        this.pdmWtCls,
        this.pdmBrnId,
        this.pdmSts,
        this.pdmPdtNm,
        this.pdmIm1,
        this.pdmIm2,
        this.pdmIm3,
        this.pdmIm4,
        this.pdmIm5,
        this.pdmIm6,
        this.pdmIm7,
        this.pdmPdtCtgyId,
        this.pdmPdtDscr,
        this.avCapId,
        this.avCapVl,
        this.acCapNm,
        this.mrpPr,
        this.slPrc,
        this.amAtrVl,
        this.lvPdtNm,
        this.pdmPdtMdl,
        this.pdmWt,
    });

    String pdmId;
    String pdmPdtId;
    String pdmAcv;
    String stmCurrStkQty;
    String pdmWtCls;
    String pdmBrnId;
    String pdmSts;
    String pdmPdtNm;
    String pdmIm1;
    String pdmIm2;
    String pdmIm3;
    String pdmIm4;
    String pdmIm5;
    String pdmIm6;
    String pdmIm7;
    String pdmPdtCtgyId;
    String pdmPdtDscr;
    String avCapId;
    String avCapVl;
    String acCapNm;
    String mrpPr;
    String slPrc;
    String amAtrVl;
    String lvPdtNm;
    String pdmPdtMdl;
    String pdmWt;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        pdmId: json["pdm_id"],
        pdmPdtId: json["pdm_pdt_id"],
        pdmAcv: json["pdm_acv"],
        stmCurrStkQty: json["stm_curr_stk_qty"],
        pdmWtCls: json["pdm_wt_cls"],
        pdmBrnId: json["pdm_brn_id"],
        pdmSts: json["pdm_sts"],
        pdmPdtNm: json["pdm_pdt_nm"],
        pdmIm1: json["pdm_im1"],
        pdmIm2: json["pdm_im2"],
        pdmIm3: json["pdm_im3"],
        pdmIm4: json["pdm_im4"],
        pdmIm5: json["pdm_im5"],
        pdmIm6: json["pdm_im6"],
        pdmIm7: json["pdm_im7"],
        pdmPdtCtgyId: json["pdm_pdt_ctgy_id"],
        pdmPdtDscr: json["pdm_pdt_dscr"],
        avCapId: json["av_cap_id"],
        avCapVl: json["av_cap_vl"],
        acCapNm: json["ac_cap_nm"],
        mrpPr: json["mrp_pr"],
        slPrc: json["sl_prc"],
        amAtrVl: json["am_atr_vl"],
        lvPdtNm: json["lv_pdt_nm"],
        pdmPdtMdl: json["pdm_pdt_mdl"],
        pdmWt: json["pdm_wt"],
    );

    Map<String, dynamic> toJson() => {
        "pdm_id": pdmId,
        "pdm_pdt_id": pdmPdtId,
        "pdm_acv": pdmAcv,
        "stm_curr_stk_qty": stmCurrStkQty,
        "pdm_wt_cls": pdmWtCls,
        "pdm_brn_id": pdmBrnId,
        "pdm_sts": pdmSts,
        "pdm_pdt_nm": pdmPdtNm,
        "pdm_im1": pdmIm1,
        "pdm_im2": pdmIm2,
        "pdm_im3": pdmIm3,
        "pdm_im4": pdmIm4,
        "pdm_im5": pdmIm5,
        "pdm_im6": pdmIm6,
        "pdm_im7": pdmIm7,
        "pdm_pdt_ctgy_id": pdmPdtCtgyId,
        "pdm_pdt_dscr": pdmPdtDscr,
        "av_cap_id": avCapId,
        "av_cap_vl": avCapVl,
        "ac_cap_nm": acCapNm,
        "mrp_pr": mrpPr,
        "sl_prc": slPrc,
        "am_atr_vl": amAtrVl,
        "lv_pdt_nm": lvPdtNm,
        "pdm_pdt_mdl": pdmPdtMdl,
        "pdm_wt": pdmWt,
    };
}

