import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/usecases/fetch_hotels_use_case.dart';

part 'hotel_cubit.freezed.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final FetchHotelsUseCase _fetchHotelsUseCase;

  HotelCubit(this._fetchHotelsUseCase) : super(const HotelState.loading());

  Future<void> fetchHotels() async {
    emit(const HotelState.loading());

    final result = await _fetchHotelsUseCase();

    result.fold(
      (failure) => emit(HotelState.error(failure.message)),
      (hotels) {
        if (hotels.isEmpty) {
          emit(const HotelState.empty());
        } else {
          emit(HotelState.loaded(hotels));
        }
      },
    );
  }
}
