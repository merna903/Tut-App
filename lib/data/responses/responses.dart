import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.id,this.name,this.numOfNotifications);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String,dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.phone,this.email,this.link);

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  Map<String,dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer,this.contacts);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String,dynamic> toJson() => _$AuthenticationResponseToJson(this);

}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse{
  @JsonKey(name: "support")
  String support;

  ForgotPasswordResponse(this.support);

  factory ForgotPasswordResponse.fromJson( Map<String,dynamic>json)=>
      _$ForgotPasswordResponseFromJson(json);

  Map<String,dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class ServiceResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  ServiceResponse(this.id,this.title,this.image);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);

  Map<String,dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class BannersResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  BannersResponse(this.id,this.link,this.title,this.image);

  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);

  Map<String,dynamic> toJson() => _$BannersResponseToJson(this);
}

@JsonSerializable()
class StoreResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  StoreResponse(this.id,this.title,this.image);

  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

  Map<String,dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class DataResponse{
  @JsonKey(name: "services")
  List<ServiceResponse>? service;
  @JsonKey(name: "banners")
  List<BannersResponse>? banner;
  @JsonKey(name: "stores")
  List<StoreResponse>? store;

  DataResponse(this.service,this.banner,this.store);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String,dynamic> toJson() => _$DataResponseToJson(this);

}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  DataResponse? data;

  HomeResponse(this.data);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String,dynamic> toJson() => _$HomeResponseToJson(this);

}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse{
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "services")
  String? services;
  @JsonKey(name: "about")
  String? about;

  StoreDetailsResponse(this.image,this.id,this.title,this.details,this.services,this.about);

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);

  Map<String,dynamic> toJson() => _$StoreDetailsResponseToJson(this);

}