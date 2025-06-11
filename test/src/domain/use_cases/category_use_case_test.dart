import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/category_repository.dart';
import 'package:mera_bazaar/src/domain/use_cases/category/category_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'category_use_case_test.mocks.dart';

@GenerateMocks([CategoryRepository])
void main() {
  setUpAll(() {
    provideDummy<DataState<List<CategoryEntity>>>(
      DataSuccess<List<CategoryEntity>>(data: []),
    );
  });

  late CategoryRepository repository;
  late CategoryUseCase categoryUseCase;

  setUp(() {
    repository = MockCategoryRepository();
    categoryUseCase = CategoryUseCase(categoryRepository: repository);
  });

  group("Category Use Case ()", () {
    test('should return a list of categories when successful', () async {
      // Arrange: Define the behavior of the mock repository
      final expectedCategories = [
        const CategoryEntity(id: '1', name: 'Electronics', imageUrl: ''),
        const CategoryEntity(id: '2', name: 'Clothes', imageUrl: ''),
      ];

      // When getCategories() is called on the mock, return success data
      when(
        repository.getCategories(),
      ).thenAnswer((_) async => DataSuccess(data: expectedCategories));

      // Act: Call the method on the class under test
      final result = await categoryUseCase();

      print("Result: ${result.data}");

      // Assert: Verify the result and mock interactions
      expect(result, isA<DataSuccess<List<CategoryEntity>>>());
      expect(result.data, expectedCategories);

      // Verify that the getCategories method was called exactly once on the mock
      verify(repository.getCategories()).called(1);
      verifyNoMoreInteractions(
        repository,
      ); // Optional: ensure no other methods were called
    });

    test(
      'should return a DataFailed when repository returns an error',
      () async {
        // Arrange: Define the mock's behavior to simulate an error
        final exception = NetworkException.fromDioError(
          DioException(requestOptions: RequestOptions()),
        );

        when(
          repository.getCategories(),
        ).thenAnswer((_) async => DataError(exception: exception));

        // Act
        final result = await categoryUseCase();

        print("Result: ${result.exception}");

        // Assert
        expect(result, isA<DataError<List<CategoryEntity>>>());
        expect(result.exception, exception);
        verify(repository.getCategories()).called(1);
      },
    );
  });
}
