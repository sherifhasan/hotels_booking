import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotels_booking/presentation/cubits/favourite/favourite_cubit.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/failure.dart';
import 'package:hotels_booking/domain/usecases/favourite/favourite_usecases.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes for use cases
class MockAddToFavouritesUseCase extends Mock
    implements AddToFavouritesUseCase {}

class MockRemoveFromFavouritesUseCase extends Mock
    implements RemoveFromFavouritesUseCase {}

class MockGetFavouritesUseCase extends Mock implements GetFavouritesUseCase {}

void main() {
  late FavouriteCubit favouriteCubit;
  late MockAddToFavouritesUseCase mockAddToFavouritesUseCase;
  late MockRemoveFromFavouritesUseCase mockRemoveFromFavouritesUseCase;
  late MockGetFavouritesUseCase mockGetFavouritesUseCase;

  setUp(() {
    mockAddToFavouritesUseCase = MockAddToFavouritesUseCase();
    mockRemoveFromFavouritesUseCase = MockRemoveFromFavouritesUseCase();
    mockGetFavouritesUseCase = MockGetFavouritesUseCase();
    favouriteCubit = FavouriteCubit(
      mockGetFavouritesUseCase,
      mockAddToFavouritesUseCase,
      mockRemoveFromFavouritesUseCase,
    );
  });

  tearDown(() {
    favouriteCubit.close();
  });

  final hotel = HotelEntity(
    hotelId: '1',
    name: 'Hotel AluaVillage Blue Beach',
    destination: 'Playa de Esquinzo, Fuerteventura, Spanien',
    imageUrl: 'https://example.com/hotel.jpg',
    ratingScore: 5.0,
    scoreDescription: 'sehr gut',
    days: 8,
    nights: 7,
    roomName: 'Doppelzimmer',
    boarding: 'Frühstück',
    adultCount: 2,
    childrenCount: 2,
    flightIncluded: true,
    totalPrice: 1280,
    pricePerPerson: 320,
  );

  group('FavouriteCubit Tests', () {
    blocTest<FavouriteCubit, FavouriteState>(
      'emits [loading, loaded] when loadFavourites is successful with data',
      build: () {
        when(() => mockGetFavouritesUseCase())
            .thenReturn(Right([hotel])); // Use synchronous return here
        return favouriteCubit;
      },
      act: (cubit) => cubit.loadFavourites(),
      expect: () => [
        const FavouriteState.loading(),
        FavouriteState.loaded([hotel]),
      ],
      verify: (_) {
        verify(() => mockGetFavouritesUseCase()).called(1);
      },
    );

    blocTest<FavouriteCubit, FavouriteState>(
      'emits [loading, empty] when loadFavourites returns empty list',
      build: () {
        when(() => mockGetFavouritesUseCase())
            .thenReturn(const Right([])); // Return an empty list
        return favouriteCubit;
      },
      act: (cubit) => cubit.loadFavourites(),
      expect: () => [
        const FavouriteState.loading(),
        const FavouriteState.empty(),
      ],
      verify: (_) {
        verify(() => mockGetFavouritesUseCase()).called(1);
      },
    );

    blocTest<FavouriteCubit, FavouriteState>(
      'emits [loaded] with hotel added when addFavourite is called',
      build: () {
        when(() => mockAddToFavouritesUseCase(hotel))
            .thenAnswer((_) async => const Right(null));
        return favouriteCubit..emit(FavouriteState.loaded([])); // Initial state
      },
      act: (cubit) => cubit.addFavourite(hotel),
      expect: () => [
        FavouriteState.loaded([hotel]),
      ],
      verify: (_) {
        verify(() => mockAddToFavouritesUseCase(hotel)).called(1);
      },
    );

    blocTest<FavouriteCubit, FavouriteState>(
      'emits [loaded] with hotel removed when there is only one in favorites',
      build: () {
        when(() => mockRemoveFromFavouritesUseCase(hotel.hotelId)).thenAnswer(
            (_) async => const Right(null)); // Mock successful removal

        return favouriteCubit
          ..emit(FavouriteState.loaded(
              [hotel])); // Set initial state with a favorite
      },
      act: (cubit) => cubit.removeFavourite(hotel.hotelId),
      // Call to remove the hotel
      expect: () => [
        FavouriteState.empty(), // Expect the state to update to an empty list
      ],
      verify: (_) {
        verify(() => mockRemoveFromFavouritesUseCase(hotel.hotelId))
            .called(1); // Verify the use case was called once
      },
    );
    blocTest<FavouriteCubit, FavouriteState>(
      'emits [loaded] with one hotel removed when there are multiple favorites',
      build: () {
        when(() => mockRemoveFromFavouritesUseCase(hotel.hotelId)).thenAnswer(
            (_) async => const Right(null)); // Mock successful removal

        final hotel2 =
            hotel.copyWith(hotelId: '2'); // Add another hotel to the list

        return favouriteCubit
          ..emit(FavouriteState.loaded(
              [hotel, hotel2])); // Set initial state with multiple favorites
      },
      act: (cubit) => cubit.removeFavourite(hotel.hotelId),
      // Call to remove the first hotel
      expect: () => [
        FavouriteState.loaded([hotel.copyWith(hotelId: '2')]),
        // Expect the state to contain only the remaining hotel
      ],
      verify: (_) {
        verify(() => mockRemoveFromFavouritesUseCase(hotel.hotelId))
            .called(1); // Verify the use case was called once
      },
    );

    blocTest<FavouriteCubit, FavouriteState>(
      'emits [error] when loadFavourites fails',
      build: () {
        when(() => mockGetFavouritesUseCase()).thenReturn(Left(
            DatabaseFailure('Database error occurred.'))); // Simulate failure
        return favouriteCubit;
      },
      act: (cubit) => cubit.loadFavourites(),
      expect: () => [
        const FavouriteState.loading(),
        const FavouriteState.error('An unexpected error occurred.'),
      ],
      verify: (_) {
        verify(() => mockGetFavouritesUseCase()).called(1);
      },
    );
  });
}
