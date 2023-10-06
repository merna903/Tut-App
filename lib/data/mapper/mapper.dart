import 'package:new_project/app/constants.dart';
import 'package:new_project/app/extensions.dart';
import 'package:new_project/data/responses/responses.dart';
import 'package:new_project/domain/models.dart';

extension CustomerResponseMapper on CustomerResponse?{
  Customer toDomain(){
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero
    );
  }
}

extension ContactsResponseMapper on ContactsResponse?{
  Contacts toDomain(){
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse{
  String toDomain(){
    return support.orEmpty();
  }
}

extension ServiceResponseMapper on ServiceResponse?{
  Services toDomain(){
    return Services(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension BannersResponseMapper on BannersResponse?{
  Banners toDomain(){
    return Banners(
        this?.id.orZero() ?? Constants.zero,
        this?.link.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse?{
  Stores toDomain(){
    return Stores(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse?{
  Home toDomain() {
    List<Services> services =
        (this?.data?.service?.map((serv) => serv.toDomain()) ??
                const Iterable.empty())
            .cast<Services>()
            .toList();
    List<Banners> banners = (this?.data?.banner?.map((ban) => ban.toDomain()) ??
            const Iterable.empty())
        .cast<Banners>()
        .toList();
    List<Stores> stores = (this?.data?.store?.map((str) => str.toDomain()) ??
            const Iterable.empty())
        .cast<Stores>()
        .toList();
    var data = Data(services, banners, stores);
    return Home(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse?{
  StoreDetails toDomain() {
    return StoreDetails(
      this?.image.orEmpty() ?? Constants.empty,
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.details.orEmpty() ?? Constants.empty,
      this?.services.orEmpty() ?? Constants.empty,
      this?.about.orEmpty() ?? Constants.empty,
    );
  }
}