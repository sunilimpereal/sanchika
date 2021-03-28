// To parse this JSON data, do
//
//     final orderuserDetailsRequestModel = orderuserDetailsRequestModelFromJson(jsonString);

import 'dart:convert';

OrderuserDetailsRequestModel orderuserDetailsRequestModelFromJson(String str) => OrderuserDetailsRequestModel.fromJson(json.decode(str));

String orderuserDetailsRequestModelToJson(OrderuserDetailsRequestModel data) => json.encode(data.toJson());

class OrderuserDetailsRequestModel {
    OrderuserDetailsRequestModel({
        this.acountNumber,
        this.bankName,
        this.billingAdderss,
        this.bilPinCode,
        this.city,
        this.ctty2,
        this.company,
        this.contactPrrson,
        this.country,
        this.coupon,
        this.dateOfBirth,
        this.firstName,
        this.udIstAr,
        this.lastName,
        this.localy,
        this.localy2,
        this.mobile,
        this.occpation,
        this.permanentAddress1,
        this.permanentAddress2,
        this.phonenumber,
        this.photograph,
        this.photographId,
        this.pin,
        this.pin2,
        this.postalCode,
        this.schedileCode,
        this.schedileName,
        this.scheduleZipCode,
        this.shippingAddress1,
        this.shippingAddress2,
        this.state,
        this.state2,
        this.udTchCd,
        this.udTinNmb,
        this.udUsrCtGrp,
        this.companyName,
        this.ifscNumber,
        this.userId,
    });

    String acountNumber;
    String bankName;
    String billingAdderss;
    int bilPinCode;
    String city;
    String ctty2;
    String company;
    String contactPrrson;
    String country;
    String coupon;
    String dateOfBirth;
    String firstName;
    String udIstAr;
    String lastName;
    String localy;
    String localy2;
    String mobile;
    String occpation;
    String permanentAddress1;
    String permanentAddress2;
    String phonenumber;
    String photograph;
    String photographId;
    String pin;
    String pin2;
    String postalCode;
    String schedileCode;
    String schedileName;
    String scheduleZipCode;
    String shippingAddress1;
    String shippingAddress2;
    String state;
    String state2;
    String udTchCd;
    String udTinNmb;
    String udUsrCtGrp;
    String companyName;
    String ifscNumber;
    String userId;

    factory OrderuserDetailsRequestModel.fromJson(Map<String, dynamic> json) => OrderuserDetailsRequestModel(
        acountNumber: json["acountNumber"],
        bankName: json["bankName"],
        billingAdderss: json["billingAdderss"],
        bilPinCode: json["bilPinCode"],
        city: json["city"],
        ctty2: json["ctty2"],
        company: json["company"],
        contactPrrson: json["contactPrrson"],
        country: json["country"],
        coupon: json["coupon"],
        dateOfBirth: json["dateOfBirth"],
        firstName: json["firstName"],
        udIstAr: json["ud_ist_ar"],
        lastName: json["lastName"],
        localy: json["localy"],
        localy2: json["localy2"],
        mobile: json["mobile"],
        occpation: json["occpation"],
        permanentAddress1: json["permanentAddress1"],
        permanentAddress2: json["permanentAddress2"],
        phonenumber: json["phonenumber"],
        photograph: json["photograph"],
        photographId: json["photographId"],
        pin: json["pin"],
        pin2: json["pin2"],
        postalCode: json["postalCode"],
        schedileCode: json["schedileCode"],
        schedileName: json["schedileName"],
        scheduleZipCode: json["scheduleZipCode"],
        shippingAddress1: json["shippingAddress1"],
        shippingAddress2: json["shippingAddress2"],
        state: json["state"],
        state2: json["state2"],
        udTchCd: json["ud_tch_cd"],
        udTinNmb: json["ud_tin_nmb"],
        udUsrCtGrp: json["ud_usr_ct_grp"],
        companyName: json["companyName"],
        ifscNumber: json["ifscNumber"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "acountNumber": acountNumber,
        "bankName": bankName,
        "billingAdderss": billingAdderss,
        "bilPinCode": bilPinCode,
        "city": city,
        "ctty2": ctty2,
        "company": company,
        "contactPrrson": contactPrrson,
        "country": country,
        "coupon": coupon,
        "dateOfBirth": dateOfBirth,
        "firstName": firstName,
        "ud_ist_ar": udIstAr,
        "lastName": lastName,
        "localy": localy,
        "localy2": localy2,
        "mobile": mobile,
        "occpation": occpation,
        "permanentAddress1": permanentAddress1,
        "permanentAddress2": permanentAddress2,
        "phonenumber": phonenumber,
        "photograph": photograph,
        "photographId": photographId,
        "pin": pin,
        "pin2": pin2,
        "postalCode": postalCode,
        "schedileCode": schedileCode,
        "schedileName": schedileName,
        "scheduleZipCode": scheduleZipCode,
        "shippingAddress1": shippingAddress1,
        "shippingAddress2": shippingAddress2,
        "state": state,
        "state2": state2,
        "ud_tch_cd": udTchCd,
        "ud_tin_nmb": udTinNmb,
        "ud_usr_ct_grp": udUsrCtGrp,
        "companyName": companyName,
        "ifscNumber": ifscNumber,
        "userId": userId,
    };
}
