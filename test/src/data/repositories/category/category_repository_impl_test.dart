import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/models/category/category_model.dart';
import 'package:mera_bazaar/src/data/repositories/category/category_repository_impl.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/category/category_entity.dart';
import 'category_repository_impl_test.mocks.dart';

@GenerateMocks([CategoryDataSource])
void main() {
  late CategoryRepositoryImpl repository;
  late MockCategoryDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCategoryDataSource();
    repository = CategoryRepositoryImpl(categoryDataSource: mockDataSource);
  });

  group('getCategories', () {
    final tCategoryModels = [
      CategoryModel(
        id: '1',
        name: 'Electronics',
        imageUrl: 'https://example.com/electronics.jpg',
        description: 'Electronic items',
      ),
      CategoryModel(
        id: '2',
        name: 'Clothing',
        imageUrl: 'https://example.com/clothing.jpg',
        description: 'Clothing items',
      ),
    ];

    final tCategoryEntities =
        tCategoryModels.map((model) => model.toEntity(model)).toList();

    test(
      'should return DataSuccess with category entities when the data source call is successful',
      () async {
        // arrange
        when(
          mockDataSource.getCategory(),
        ).thenAnswer((_) async => tCategoryModels);

        // act
        final result = await repository.getCategories();

        // assert
        expect(result, isA<DataSuccess<List<CategoryEntity>>>());
        expect(result.data, equals(tCategoryEntities));
        verify(mockDataSource.getCategory());
      },
    );

    test(
      'should return DataError with NetworkException when the data source throws a DioException',
      () async {
        // arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Network error',
        );
        when(mockDataSource.getCategory()).thenThrow(dioException);

        // act
        final result = await repository.getCategories();

        // assert
        expect(result, isA<DataError<List<CategoryEntity>>>());
        expect(result.exception, isA<NetworkException>());
        verify(mockDataSource.getCategory());
      },
    );

    test(
      'should return DataError with NetworkException when the data source throws a generic exception',
      () async {
        // arrange
        when(
          mockDataSource.getCategory(),
        ).thenThrow(Exception('Generic error'));

        // act
        final result = await repository.getCategories();

        // assert
        expect(result, isA<DataError<List<CategoryEntity>>>());
        expect(result.exception, isA<NetworkException>());
        verify(mockDataSource.getCategory());
      },
    );
  });
}
