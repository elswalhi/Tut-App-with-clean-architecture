// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:advanced_flutter/App/constance.dart';
import 'package:advanced_flutter/data/Response/responses.dart';
import 'package:advanced_flutter/App/extension.dart';
import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constance.empty,
        this?.name.orEmpty() ?? Constance.empty,
        this?.numOfNotifications.orZero() ?? Constance.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constance.empty,
        this?.email.orEmpty() ?? Constance.empty,
        this?.link.orEmpty() ?? Constance.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.contacts.toDomain(), this?.customer.toDomain());
  }
}


extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
        this?.id.orZero() ?? Constance.zero,
        this?.title.orEmpty() ?? Constance.empty,
        this?.image.orEmpty() ?? Constance.empty);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
        this?.id.orZero() ?? Constance.zero,
        this?.title.orEmpty() ?? Constance.empty,
        this?.image.orEmpty() ?? Constance.empty);
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
        this?.id.orZero() ?? Constance.zero,
        this?.title.orEmpty() ?? Constance.empty,
        this?.image.orEmpty() ?? Constance.empty,
        this?.link.orEmpty() ?? Constance.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
        ?.data
        ?.services
        ?.map((serviceResponse) => serviceResponse.toDomain()) ??
        const Iterable.empty())
        .cast<Service>()
        .toList();

    List<BannerAd> banners = (this
        ?.data
        ?.banners
        ?.map((bannersResponse) => bannersResponse.toDomain()) ??
        const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    List<Store> stores = (this
        ?.data
        ?.stores
        ?.map((storesResponse) => storesResponse.toDomain()) ??
        const Iterable.empty())
        .cast<Store>()
        .toList();

    var data = HomeData(services,  banners,stores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
        this?.id?.orZero() ?? Constance.zero,
        this?.title?.orEmpty() ?? Constance.empty,
        this?.image?.orEmpty() ?? Constance.empty,
        this?.details?.orEmpty() ?? Constance.empty,
        this?.services?.orEmpty() ?? Constance.empty,
        this?.about?.orEmpty() ?? Constance.empty);
  }
}
