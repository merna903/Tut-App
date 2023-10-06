class SliderObject{
  String title;
  String subTitle;
  String image;

  SliderObject(this.title,this.subTitle,this.image);
}

//login models

class Customer{
  String id;
  String name;
  int  numOfNotifications;

  Customer(this.id,this.name,this.numOfNotifications);
}

class Contacts{
  String phone;
  String email;
  String link;

  Contacts(this.phone,this.email,this.link);
}

class Authentication{
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer,this.contacts);
}

class Services{
  int id;
  String title;
  String image;

  Services(this.id,this.title,this.image);
}

class Banners{
  int id;
  String link;
  String title;
  String image;

  Banners(this.id,this.link,this.title,this.image);
}

class Stores{
  int id;
  String title;
  String image;

  Stores(this.id,this.title,this.image);
}

class Data{
  List<Services> service;
  List<Banners> banner;
  List<Stores> store;

  Data(this.service,this.banner,this.store);
}
class Home{
  Data? data;
  Home(this.data);
}

class StoreDetails{
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails(this.image,this.id,this.title,this.details,this.services,this.about);
}