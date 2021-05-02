// To parse this JSON data, do
//
//     final paymentUpdate = paymentUpdateFromJson(jsonString);

import 'dart:convert';

PaymentUpdate paymentUpdateFromJson(String str) => PaymentUpdate.fromJson(json.decode(str));

String paymentUpdateToJson(PaymentUpdate data) => json.encode(data.toJson());

class PaymentUpdate {
    PaymentUpdate({
        this.wohPymMod,
        this.wohPymTyp,
        this.wohTxId,
    });

    String wohPymMod;
    String wohPymTyp;
    String wohTxId;

    factory PaymentUpdate.fromJson(Map<String, dynamic> json) => PaymentUpdate(
        wohPymMod: json["woh_pym_mod"],
        wohPymTyp: json["woh_pym_typ"],
        wohTxId: json["woh_tx_id"],
    );

    Map<String, dynamic> toJson() => {
        "woh_pym_mod": wohPymMod,
        "woh_pym_typ": wohPymTyp,
        "woh_tx_id": wohTxId,
    };
}
