import 'dart:convert';

List<Operation> operationFromJson(String str) =>
    List<Operation>.from(json.decode(str).map((x) => Operation.fromJson(x)));

String operationToJson(List<Operation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Operation {
  String? operationId;
  String? userId;
  String? countryFrom;
  String? regionFrom;
  String? provinceFrom;
  String? cityFrom;
  String? addressFrom;
  String? countryTo;
  String? regionTo;
  String? provinceTo;
  String? cityTo;
  String? addressTo;
  String? requestType;
  String? description;
  String? consent;
  String? currentDateTime;
  String? updateDateTime;
  String? domain;
  String? adminOpen;
  String? supplierId;
  String? supplierDescription;
  String? supplierOpen;
  String? supplierAccept;
  String? closed;
  String? requestId;
  String? paid;
  String? cost;
  String? price;
  String? invoiceId;
  String? visits;
  String? signedUrl;
  String? signedDateTime;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userCountry;
  String? userRegion;
  String? userProvince;
  String? userCity;
  String? userAddress;
  String? userInvoiceName;
  String? userInvoiceCf;
  String? userInvoiceVat;
  String? userInvoiceCountry;
  String? userInvoiceProvince;
  String? userInvoiceCity;
  String? userInvoiceAddress;
  String? userInvoiceCap;
  String? userInvoiceSdi;
  String? userInvoicePec;
  String? supplierEmail;
  String? supplierName;
  String? supplierPhone;
  String? supplierType;
  String? supplierCf;
  String? supplierCountry;
  String? supplierRegion;
  String? supplierProvince;
  String? supplierCity;
  String? supplierAddress;
  String? supplierProfilePicture;
  String? supplierDeviceToken;
  String? supplierNotificationPermission;
  String? supplierIsLogged;
  String? verified;
  String? curriculum;
  String? createdDateTime;
  String? coverageArea;
  String? settingId;
  String? settingYear;

  Operation({
    this.operationId,
    this.userId,
    this.countryFrom,
    this.regionFrom,
    this.provinceFrom,
    this.cityFrom,
    this.addressFrom,
    this.countryTo,
    this.regionTo,
    this.provinceTo,
    this.cityTo,
    this.addressTo,
    this.requestType,
    this.description,
    this.consent,
    this.currentDateTime,
    this.updateDateTime,
    this.domain,
    this.adminOpen,
    this.supplierId,
    this.supplierDescription,
    this.supplierOpen,
    this.supplierAccept,
    this.closed,
    this.requestId,
    this.paid,
    this.cost,
    this.price,
    this.invoiceId,
    this.visits,
    this.signedUrl,
    this.signedDateTime,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userCountry,
    this.userRegion,
    this.userProvince,
    this.userCity,
    this.userAddress,
    this.userInvoiceName,
    this.userInvoiceCf,
    this.userInvoiceVat,
    this.userInvoiceCountry,
    this.userInvoiceProvince,
    this.userInvoiceCity,
    this.userInvoiceAddress,
    this.userInvoiceCap,
    this.userInvoiceSdi,
    this.userInvoicePec,
    this.supplierEmail,
    this.supplierName,
    this.supplierPhone,
    this.supplierType,
    this.supplierCf,
    this.supplierCountry,
    this.supplierRegion,
    this.supplierProvince,
    this.supplierCity,
    this.supplierAddress,
    this.supplierProfilePicture,
    this.supplierDeviceToken,
    this.supplierNotificationPermission,
    this.supplierIsLogged,
    this.verified,
    this.curriculum,
    this.createdDateTime,
    this.coverageArea,
    this.settingId,
    this.settingYear,
  });

  factory Operation.fromJson(Map<String, dynamic> json) => Operation(
        operationId: json["operation_id"] ?? '',
        userId: json["user_id"] ?? '',
        countryFrom: json["countryFrom"] ?? '',
        regionFrom: json["regionFrom"] ?? '',
        provinceFrom: json["provinceFrom"] ?? '',
        cityFrom: json["cityFrom"] ?? '',
        addressFrom: json["addressFrom"] ?? '',
        countryTo: json["countryTo"] ?? '',
        regionTo: json["regionTo"] ?? '',
        provinceTo: json["provinceTo"] ?? '',
        cityTo: json["cityTo"] ?? '',
        addressTo: json["addressTo"] ?? '',
        requestType: json["request_type"] ?? '',
        description: json["description"] ?? '',
        consent: json["consent"] ?? '',
        currentDateTime: json["currentDateTime"] ?? '',
        updateDateTime: json["updateDateTime"] ?? '',
        domain: json["domain"] ?? '',
        adminOpen: json["admin_open"] ?? '',
        supplierId: json["supplier_id"] ?? '',
        supplierDescription: json["supplier_description"] ?? '',
        supplierOpen: json["supplier_open"] ?? '',
        supplierAccept: json["supplier_accept"] ?? '',
        closed: json["closed"] ?? '',
        requestId: json["request_id"] ?? '',
        paid: json["paid"] ?? '',
        cost: json["cost"] ?? '',
        price: json["price"] ?? '',
        invoiceId: json["invoice_id"] ?? '',
        visits: json["visits"] ?? '',
        signedUrl: json["signed_url"] ?? '',
        signedDateTime: json["signed_dateTime"] ?? '',
        userName: json["user_name"] ?? '',
        userEmail: json["user_email"] ?? '',
        userPhone: json["user_phone"] ?? '',
        userCountry: json["user_country"] ?? '',
        userRegion: json["user_region"] ?? '',
        userProvince: json["user_province"] ?? '',
        userCity: json["user_city"] ?? '',
        userAddress: json["user_address"] ?? '',
        userInvoiceName: json["user_invoice_name"] ?? '',
        userInvoiceCf: json["user_invoice_cf"] ?? '',
        userInvoiceVat: json["user_invoice_vat"] ?? '',
        userInvoiceCountry: json["user_invoice_country"] ?? '',
        userInvoiceProvince: json["user_invoice_province"] ?? '',
        userInvoiceCity: json["user_invoice_city"] ?? '',
        userInvoiceAddress: json["user_invoice_address"] ?? '',
        userInvoiceCap: json["user_invoice_cap"] ?? '',
        userInvoiceSdi: json["user_invoice_sdi"] ?? '',
        userInvoicePec: json["user_invoice_pec"] ?? '',
        supplierEmail: json["supplier_email"] ?? '',
        supplierName: json["supplier_name"] ?? '',
        supplierPhone: json["supplier_phone"] ?? '',
        supplierType: json["supplier_type"] ?? '',
        supplierCf: json["supplier_cf"] ?? '',
        supplierCountry: json["supplier_country"] ?? '',
        supplierRegion: json["supplier_region"] ?? '',
        supplierProvince: json["supplier_province"] ?? '',
        supplierCity: json["supplier_city"] ?? '',
        supplierAddress: json["supplier_address"] ?? '',
        supplierProfilePicture: json["supplier_profile_picture"] ?? '',
        supplierDeviceToken: json["supplier_device_token"] ?? '',
        supplierNotificationPermission:
            json["supplier_notification_permission"] ?? '',
        supplierIsLogged: json["supplier_is_logged"] ?? '',
        verified: json["verified"] ?? '',
        curriculum: json["curriculum"] ?? '',
        createdDateTime: json["createdDateTime"] ?? '',
        coverageArea: json["coverage_area"] ?? '',
        settingId: json["setting_id"] ?? '',
        settingYear: json["setting_year"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "operation_id": operationId ?? '',
        "user_id": userId ?? '',
        "countryFrom": countryFrom ?? '',
        "regionFrom": regionFrom ?? '',
        "provinceFrom": provinceFrom ?? '',
        "cityFrom": cityFrom ?? '',
        "addressFrom": addressFrom ?? '',
        "countryTo": countryTo ?? '',
        "regionTo": regionTo ?? '',
        "provinceTo": provinceTo ?? '',
        "cityTo": cityTo ?? '',
        "addressTo": addressTo ?? '',
        "request_type": requestType ?? '',
        "description": description ?? '',
        "consent": consent ?? '',
        "currentDateTime": currentDateTime ?? '',
        "updateDateTime": updateDateTime ?? '',
        "domain": domain ?? '',
        "admin_open": adminOpen ?? '',
        "supplier_id": supplierId ?? '',
        "supplier_description": supplierDescription ?? '',
        "supplier_open": supplierOpen ?? '',
        "supplier_accept": supplierAccept ?? '',
        "closed": closed ?? '',
        "request_id": requestId ?? '',
        "paid": paid ?? '',
        "cost": cost ?? '',
        "price": price ?? '',
        "invoice_id": invoiceId ?? '',
        "visits": visits ?? '',
        "signed_url": signedUrl ?? '',
        "signed_dateTime": signedDateTime ?? '',
        "user_name": userName ?? '',
        "user_email": userEmail ?? '',
        "user_phone": userPhone ?? '',
        "user_country": userCountry ?? '',
        "user_region": userRegion ?? '',
        "user_province": userProvince ?? '',
        "user_city": userCity ?? '',
        "user_address": userAddress ?? '',
        "user_invoice_name": userInvoiceName ?? '',
        "user_invoice_cf": userInvoiceCf ?? '',
        "user_invoice_vat": userInvoiceVat ?? '',
        "user_invoice_country": userInvoiceCountry ?? '',
        "user_invoice_province": userInvoiceProvince ?? '',
        "user_invoice_city": userInvoiceCity ?? '',
        "user_invoice_address": userInvoiceAddress ?? '',
        "user_invoice_cap": userInvoiceCap ?? '',
        "user_invoice_sdi": userInvoiceSdi ?? '',
        "user_invoice_pec": userInvoicePec ?? '',
        "supplier_email": supplierEmail ?? '',
        "supplier_name": supplierName ?? '',
        "supplier_phone": supplierPhone ?? '',
        "supplier_type": supplierType ?? '',
        "supplier_cf": supplierCf ?? '',
        "supplier_country": supplierCountry ?? '',
        "supplier_region": supplierRegion ?? '',
        "supplier_province": supplierProvince ?? '',
        "supplier_city": supplierCity ?? '',
        "supplier_address": supplierAddress ?? '',
        "supplier_profile_picture": supplierProfilePicture ?? '',
        "supplier_device_token": supplierDeviceToken ?? '',
        "supplier_notification_permission":
            supplierNotificationPermission ?? '',
        "supplier_is_logged": supplierIsLogged ?? '',
        "verified": verified ?? '',
        "curriculum": curriculum ?? '',
        "createdDateTime": createdDateTime ?? '',
        "coverage_area": coverageArea ?? '',
        "setting_id": settingId ?? '',
        "setting_year": settingYear ?? '',
      };
}
