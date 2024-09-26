import 'package:hive/hive.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

class FavouriteLocalDataSource {
  static const _favouritesBox = 'favourites';

  Future<List<HotelEntity>> getFavourites() async {
    var box = await Hive.openBox<HotelEntity>(_favouritesBox);
    return box.values.toList();
  }

  Future<void> addToFavourites(HotelEntity hotel) async {
    var box = await Hive.openBox<HotelEntity>(_favouritesBox);
    await box.put(hotel.hotelId, hotel);
  }

  Future<void> removeFromFavourites(String hotelId) async {
    var box = await Hive.openBox<HotelEntity>(_favouritesBox);
    await box.delete(hotelId);
  }
}
