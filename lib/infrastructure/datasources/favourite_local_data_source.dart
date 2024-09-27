import 'package:hive/hive.dart';
import 'package:hotels_booking/infrastructure/storage/hotel_database_model.dart';
import 'package:hotels_booking/setup.dart';

class FavouriteLocalDataSource {
  static const favouritesBox = 'favourites';
  final box = getIt<Box<HotelHiveModel>>();

  List<HotelHiveModel> getFavourites() {
    return box.values.toList();
  }

  Future<void> addToFavourites(HotelHiveModel hotel) async {
    await box.put(hotel.hotelId, hotel);
  }

  Future<void> removeFromFavourites(String hotelId) async {
    await box.delete(hotelId);
  }
}
