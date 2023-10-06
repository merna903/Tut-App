import 'package:new_project/data/network/error_handler.dart';
import 'package:new_project/data/responses/responses.dart';

const cacheHomeKey = 'cacheHomeKey';
const cacheDetailsKey = 'cacheDetailsKey';
const cacheHomeInterval = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getDetails();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
  Future<void> saveDetailToCache(StoreDetailsResponse storeDetailsResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl extends LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];
    return cachedItem != null && cachedItem.isValid(cacheHomeInterval)
        ? cachedItem.data
        : throw ErrorHandler.handle(DataSource.cacheError);
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getDetails() async {
    CachedItem? cachedItem = cacheMap[cacheDetailsKey];
    return cachedItem != null && cachedItem.isValid(cacheHomeInterval)
        ? cachedItem.data
        : throw ErrorHandler.handle(DataSource.cacheError);
  }

  @override
  Future<void> saveDetailToCache(StoreDetailsResponse storeDetailsResponse) async {
    cacheMap[cacheDetailsKey] = CachedItem(storeDetailsResponse);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtention on CachedItem {
  bool isValid(int expirationTime) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    return currentTime - cacheTime <= expirationTime;
  }
}
