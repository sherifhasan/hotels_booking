import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotels_booking/application/hotel_cubit.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/failure.dart';
import 'package:hotels_booking/domain/usecases/fetch_hotels_use_case.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockFetchHotelsUseCase extends Mock implements FetchHotelsUseCase {}

void main() {
  late MockFetchHotelsUseCase fetchHotelsUseCase;

  late HotelCubit hotelCubit;

  setUp(() {
    fetchHotelsUseCase = MockFetchHotelsUseCase();

    hotelCubit = HotelCubit(
      fetchHotelsUseCase,
    );
  });

  tearDown(() {
    hotelCubit.close();
  });

  group('HotelCubit tests', () {
    final List<HotelEntity> hotels = [
      HotelEntity(
        hotelId: '1',
        name: 'Hotel AluaVillage Blue Beach',
        destination: 'Playa de Esquinzo, Fuerteventura, Spanien',
        imageUrl: 'https://example.com/hotel.jpg',
        ratingScore: 5.0,
        days: 8,
        nights: 7,
        roomName: 'Doppelzimmer',
        boarding: 'Frühstück',
        adultCount: 2,
        childrenCount: 2,
        flightIncluded: true,
        totalPrice: 1280,
        pricePerPerson: 320,
      ),
    ];

    blocTest<HotelCubit, HotelState>(
      'emits [loading, loaded] when fetchHotels is successful with data',
      build: () {
        when(() => fetchHotelsUseCase()).thenAnswer((_) async => Right(hotels));
        return hotelCubit;
      },
      act: (cubit) => cubit.fetchHotels(),
      expect: () => [
        const HotelState.loading(),
        HotelState.loaded(hotels),
      ],
    );

    blocTest<HotelCubit, HotelState>(
      'emits [loading, empty] when fetchHotels returns empty list',
      build: () {
        when(() => fetchHotelsUseCase())
            .thenAnswer((_) async => const Right([]));
        return hotelCubit;
      },
      act: (cubit) => cubit.fetchHotels(),
      expect: () => [
        const HotelState.loading(),
        const HotelState.empty(),
      ],
    );

    blocTest<HotelCubit, HotelState>(
      'emits [loading, error] when fetchHotels fails',
      build: () {
        when(() => fetchHotelsUseCase()).thenAnswer(
            (_) async => Left(ServerFailure('Error fetching hotels')));
        return hotelCubit;
      },
      act: (cubit) => cubit.fetchHotels(),
      expect: () => [
        const HotelState.loading(),
        const HotelState.error('Error fetching hotels'),
      ],
    );
  });
}
