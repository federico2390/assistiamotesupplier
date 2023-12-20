import 'dart:convert';

List<Operation> operationFromJson(String str) =>
    List<Operation>.from(json.decode(str).map((x) => Operation.fromJson(x)));

String operationToJson(List<Operation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Operation {
  Operation({
    this.operationId,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userCountry,
    this.userRegion,
    this.userProvince,
    this.userCity,
    this.userAddress,
    this.userQuotationName,
    this.userQuotationCf,
    this.userQuotationVat,
    this.invoiceSended,
    this.userQuotationCountry,
    this.userQuotationProvince,
    this.userQuotationCity,
    this.userQuotationAddress,
    this.userQuotationCap,
    this.userQuotationSdi,
    this.userQuotationPec,
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
    this.domain,
    this.fromPlatform,
    this.adminOpen,
    this.supplierId,
    this.supplierEmail,
    this.supplierName,
    this.supplierPhone,
    this.supplierType,
    this.supplierCf,
    this.supplierVat,
    this.supplierCountry,
    this.supplierRegion,
    this.supplierProvince,
    this.supplierCity,
    this.supplierAddress,
    this.supplierProfilePicture,
    this.supplierDeviceToken,
    this.supplierNotificationPermission,
    this.supplierIsLogged,
    this.supplierDescription,
    this.supplierOpen,
    this.signedContract,
    this.signedContractUrl,
    this.supplierAccept,
    this.closed,
    this.updateDateTime,
    this.verified,
    this.curriculum,
    this.createdDateTime,
    this.requestId,
    this.paid,
    this.wirepayment,
    this.cost,
    this.quotationId,
    this.visits,
    this.signedUrl,
    this.signedDateTime,
    this.vatPercentage,
    this.supplierDoc1,
    this.supplierDoc2,
    this.supplierDoc3,
    this.supplierDoc4,
    this.note,
    this.paidSupplier,
    this.fromAmb,
  });

  String? operationId;
  String? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userCountry;
  String? userRegion;
  String? userProvince;
  String? userCity;
  String? userAddress;
  String? userQuotationName;
  String? userQuotationCf;
  String? userQuotationVat;
  String? userQuotationCountry;
  String? userQuotationProvince;
  String? userQuotationCity;
  String? userQuotationAddress;
  String? invoiceSended;
  String? userQuotationCap;
  String? userQuotationSdi;
  String? userQuotationPec;
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
  String? signedContract;
  String? signedContractUrl;
  String? requestType;
  String? description;
  String? consent;
  String? currentDateTime;
  String? domain;
  String? fromPlatform;
  String? adminOpen;
  String? supplierId;
  String? supplierEmail;
  String? supplierName;
  String? supplierPhone;
  String? supplierType;
  String? supplierCf;
  String? supplierVat;
  String? supplierCountry;
  String? supplierRegion;
  String? supplierProvince;
  String? supplierCity;
  String? supplierAddress;
  String? supplierProfilePicture;
  String? supplierDeviceToken;
  String? supplierNotificationPermission;
  String? supplierIsLogged;
  String? supplierDescription;
  String? supplierOpen;
  String? supplierAccept;
  String? closed;
  String? requestId;
  String? paid;
  String? wirepayment;
  String? cost;
  String? quotationId;
  String? verified;
  String? curriculum;
  String? createdDateTime;
  String? visits;
  String? signedUrl;
  String? signedDateTime;
  String? updateDateTime;
  String? vatPercentage;
  String? supplierDoc1;
  String? supplierDoc2;
  String? supplierDoc3;
  String? supplierDoc4;
  String? note;
  String? paidSupplier;
  String? fromAmb;

  factory Operation.fromJson(Map<String, dynamic> json) => Operation(
        operationId: json["operation_id"] ?? '',
        userId: json["user_id"] ?? '',
        userName: json["user_name"] ?? '',
        userEmail: json["user_email"] ?? '',
        userPhone: json["user_phone"] ?? '',
        userCountry: json["user_country"] ?? '',
        userRegion: json["user_region"] ?? '',
        userProvince: json["user_province"] ?? '',
        userCity: json["user_city"] ?? '',
        userAddress: json["user_address"] ?? '',
        userQuotationName: json["user_invoice_name"] ?? '',
        userQuotationCf: json["user_invoice_cf"] ?? '',
        userQuotationVat: json["user_invoice_vat"] ?? '',
        userQuotationCountry: json["user_invoice_country"] ?? '',
        userQuotationProvince: json["user_invoice_province"] ?? '',
        userQuotationCity: json["user_invoice_city"] ?? '',
        userQuotationAddress: json["user_invoice_address"] ?? '',
        userQuotationCap: json["user_invoice_cap"] ?? '',
        userQuotationSdi: json["user_invoice_sdi"] ?? '',
        userQuotationPec: json["user_invoice_pec"] ?? '',
        invoiceSended: json["invoice_sended"] ?? '',
        countryFrom: json["countryFrom"] ?? '',
        regionFrom: json["regionFrom"] ?? '',
        provinceFrom: json["provinceFrom"] ?? '',
        cityFrom: json["cityFrom"] ?? '',
        addressFrom: json["addressFrom"] ?? '',
        countryTo: json["countryTo"] ?? '',
        regionTo: json["regionTo"] ?? '',
        signedContract: json["signed_contract"] ?? '',
        signedContractUrl: json["signed_contract_url"] ?? '',
        provinceTo: json["provinceTo"] ?? '',
        cityTo: json["cityTo"] ?? '',
        addressTo: json["addressTo"] ?? '',
        requestType: json["request_type"] ?? '',
        description: json["description"] ?? '',
        consent: json["consent"] ?? '',
        currentDateTime: json["currentDateTime"] ?? '',
        domain: json["domain"] ?? '',
        fromPlatform: json["fromPlatform"] ?? '',
        adminOpen: json["admin_open"] ?? '',
        supplierId: json["supplier_id"] ?? '',
        supplierEmail: json["supplier_email"] ?? '',
        supplierName: json["supplier_name"] ?? '',
        supplierPhone: json["supplier_phone"] ?? '',
        supplierType: json["supplier_type"] ?? '',
        supplierCf: json["supplier_cf"] ?? '',
        supplierVat: json["supplier_vat"] ?? '',
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
        supplierDescription: json["supplier_description"] ?? '',
        supplierOpen: json["supplier_open"] ?? '',
        supplierAccept: json["supplier_accept"] ?? '',
        closed: json["closed"] ?? '',
        requestId: json["request_id"] ?? '',
        paid: json["paid"] ?? '',
        wirepayment: json["wirepayment"] ?? '',
        cost: json["cost"] ?? '',
        updateDateTime: json["updateDateTime"] ?? '',
        verified: json["verified"] ?? '',
        quotationId: json["quotation_id"] ?? '',
        curriculum: json["curriculum"] ?? '',
        createdDateTime: json["createdDateTime"] ?? '',
        visits: json["visits"] ?? '',
        signedUrl: json["signed_url"] ?? '',
        signedDateTime: json["signed_dateTime"] ?? '',
        vatPercentage: json["vat_percentage"] ?? '',
        supplierDoc1: json["supplier_doc_1"] ?? '',
        supplierDoc2: json["supplier_doc_2"] ?? '',
        supplierDoc3: json["supplier_doc_3"] ?? '',
        supplierDoc4: json["supplier_doc_4"] ?? '',
        note: json["note"] ?? '',
        paidSupplier: json["paid_supplier"] ?? '',
        fromAmb: json["fromAmb"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "operation_id": operationId ?? '',
        "user_id": userId ?? '',
        "user_name": userName ?? '',
        "user_email": userEmail ?? '',
        "user_phone": userPhone ?? '',
        "user_country": userCountry ?? '',
        "user_region": userRegion ?? '',
        "user_province": userProvince ?? '',
        "user_city": userCity ?? '',
        "user_address": userAddress ?? '',
        "user_invoice_name": userQuotationName ?? '',
        "user_invoice_cf": userQuotationCf ?? '',
        "user_invoice_vat": userQuotationVat ?? '',
        "user_invoice_country": userQuotationCountry ?? '',
        "user_invoice_province": userQuotationProvince ?? '',
        "user_invoice_city": userQuotationCity ?? '',
        "user_invoice_address": userQuotationAddress ?? '',
        "invoice_sended": invoiceSended ?? '',
        "user_invoice_cap": userQuotationCap ?? '',
        "user_invoice_sdi": userQuotationSdi ?? '',
        "user_invoice_pec": userQuotationPec ?? '',
        "signed_contract": signedContract ?? '',
        "signed_contract_url": signedContractUrl ?? '',
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
        "domain": domain ?? '',
        "fromPlatform": fromPlatform ?? '',
        "admin_open": adminOpen ?? '',
        "supplier_id": supplierId ?? '',
        "supplier_email": supplierEmail ?? '',
        "supplier_name": supplierName ?? '',
        "supplier_phone": supplierPhone ?? '',
        "supplier_type": supplierType ?? '',
        "supplier_cf": supplierCf ?? '',
        "supplier_vat": supplierVat ?? '',
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
        "updateDateTime": updateDateTime ?? '',
        "supplier_description": supplierDescription ?? '',
        "supplier_open": supplierOpen ?? '',
        "supplier_accept": supplierAccept ?? '',
        "closed": closed ?? '',
        "request_id": requestId ?? '',
        "paid": paid ?? '',
        "wirepayment": wirepayment ?? '',
        "cost": cost ?? '',
        "quotation_id": quotationId ?? '',
        "verified": verified ?? '',
        "curriculum": curriculum ?? '',
        "createdDateTime": createdDateTime ?? '',
        "visits": visits ?? '',
        "signed_url": signedUrl ?? '',
        "signed_dateTime": signedDateTime ?? '',
        "vat_percentage": vatPercentage ?? '',
        "supplier_doc_1": supplierDoc1 ?? '',
        "supplier_doc_2": supplierDoc2 ?? '',
        "supplier_doc_3": supplierDoc3 ?? '',
        "supplier_doc_4": supplierDoc4 ?? '',
        "note": note ?? '',
        "paid_supplier": paidSupplier ?? '',
        "fromAmb": fromAmb ?? '',
      };
}
