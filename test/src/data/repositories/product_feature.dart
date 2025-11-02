// test/product_feature_tests.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Assuming these are the paths to your actual classes
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/product/products_response.dart';
import 'package:mera_bazaar/src/data/source/remote/product/product_data_source.dart';
import 'package:mera_bazaar/src/data/source/remote/product/product_data_source_impl.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart'; // Import DataState
import 'package:mera_bazaar/src/domain/entities/product/product_entity.dart'; // Import ProductEntity
import 'package:mera_bazaar/src/domain/repositories/product_repository.dart'; // Import ProductRepository
import 'package:mera_bazaar/src/domain/usecases/get_products_usecase.dart'; // Import GetProductsUseCase

// Generate mocks for all the classes we need to control.
// This annotation tells build_runner to create mock implementations.
@GenerateMocks([
  DioClient,
  FirebaseFirestore,
  CollectionReference,
  Query, // For .where() calls
  QuerySnapshot,
  QueryDocumentSnapshot,
  ProductRepository, // Added for GetProductsUseCase tests
])
// Import the generated mock file. This file is created after running `flutter pub run build_runner build`.
// The name of the generated file will typically be 'your_test_file_name.mocks.dart'.
import 'product_feature_tests.mocks.dart';

void main() {
  // Declare late variables for our mocks and the classes under test.
  late MockDioClient mockDioClient;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockQuery<Map<String, dynamic>> mockQuery;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late ProductDataSourceImpl productDataSourceImpl;
  late MockProductRepository mockProductRepository; // New mock for UseCase
  late GetProductsUseCase getProductsUseCase; // New class under test

  // This setup function runs before each test in this group.
  setUp(() {
    // Initialize fresh mock instances for each test to ensure test isolation.
    mockDioClient = MockDioClient();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockProductRepository = MockProductRepository(); // Initialize new mock

    // Stub the common interactions for ProductDataSourceImpl tests:
    when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
        .thenReturn(mockQuery);

    // Initialize the classes under test
    productDataSourceImpl = ProductDataSourceImpl(dioClient: mockDioClient);
    getProductsUseCase = GetProductsUseCase(productRepository: mockProductRepository); // Inject mock
  });

  group('ProductDataSourceImpl', () {
    final productData1 = {
      'id': 'prod1',
      'name': 'Product A',
      'category_id': 'cat1',
      'price': 10.0,
      'description': 'Description A',
      'image_url': 'url_a',
    };
    final productData2 = {
      'id': 'prod2',
      'name': 'Product B',
      'category_id': 'cat2',
      'price': 20.0,
      'description': 'Description B',
      'image_url': 'url_b',
    };
    final productData3 = {
      'id': 'prod3',
      'name': 'Product C',
      'category_id': 'cat1',
      'price': 30.0,
      'description': 'Description C',
      'image_url': 'url_c',
    };

    final productResponse1 = ProductResponse.fromJson(productData1);
    final productResponse2 = ProductResponse.fromJson(productData2);
    final productResponse3 = ProductResponse.fromJson(productData3);

    // Helper to create mock QueryDocumentSnapshot
    MockQueryDocumentSnapshot createMockDoc(Map<String, dynamic> data) {
      final mockDoc = MockQueryDocumentSnapshot<Map<String, dynamic>>();
      when(mockDoc.data()).thenReturn(data);
      return mockDoc;
    }

    test('should return all products when categoryId is "YsXVA7X1EgWrpUWvpf8f"', () async {
      // Arrange
      final mockDocs = [
        createMockDoc(productData1),
        createMockDoc(productData2),
        createMockDoc(productData3),
      ];

      // Stub the behavior for `get()` on the collection reference.
      when(mockCollectionReference.get()).thenAnswer((_) async {
        when(mockQuerySnapshot.docs).thenReturn(mockDocs);
        return mockQuerySnapshot;
      });

      // Act
      final result = await productDataSourceImpl.getProducts(
          categoryId: "YsXVA7X1EgWrpUWvpf8f");

      // Assert
      expect(result, [productResponse1, productResponse2, productResponse3]);
      // Verify that `collection("products").get()` was called.
      verify(mockFirebaseFirestore.collection("products")).called(1);
      verify(mockCollectionReference.get()).called(1);
      // Ensure no `where` clause was used for this specific category ID.
      verifyNever(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')));
    });

    test('should return products filtered by categoryId', () async {
      // Arrange
      const String specificCategoryId = "cat1";
      final mockDocs = [
        createMockDoc(productData1),
        createMockDoc(productData3),
      ];

      // Stub the behavior for `get()` on the query (after .where()).
      when(mockQuery.get()).thenAnswer((_) async {
        when(mockQuerySnapshot.docs).thenReturn(mockDocs);
        return mockQuerySnapshot;
      });

      // Act
      final result = await productDataSourceImpl.getProducts(
          categoryId: specificCategoryId);

      // Assert
      expect(result, [productResponse1, productResponse3]);
      // Verify that `collection("products").where("category_id", isEqualTo: specificCategoryId).get()` was called.
      verify(mockFirebaseFirestore.collection("products")).called(1);
      verify(mockCollectionReference.where("category_id", isEqualTo: specificCategoryId)).called(1);
      verify(mockQuery.get()).called(1);
      // Ensure `get()` on the direct collection was never called for this scenario.
      verifyNever(mockCollectionReference.get());
    });

    test('should return an empty list when no products are found', () async {
      // Arrange
      const String nonExistentCategoryId = "nonExistent";

      // Stub the behavior to return an empty list of documents.
      when(mockQuery.get()).thenAnswer((_) async {
        when(mockQuerySnapshot.docs).thenReturn([]);
        return mockQuerySnapshot;
      });

      // Act
      final result = await productDataSourceImpl.getProducts(
          categoryId: nonExistentCategoryId);

      // Assert
      expect(result, isEmpty);
      verify(mockFirebaseFirestore.collection("products")).called(1);
      verify(mockCollectionReference.where("category_id", isEqualTo: nonExistentCategoryId)).called(1);
      verify(mockQuery.get()).called(1);
    });

    test('should throw an exception when Firestore operation fails', () async {
      // Arrange
      const String categoryId = "cat1";
      final exception = FirebaseException(plugin: 'Firestore', message: 'Permission Denied');

      // Stub the behavior to throw an exception when `get()` is called.
      when(mockQuery.get()).thenThrow(exception);

      // Act & Assert
      expectLater(
            () => productDataSourceImpl.getProducts(categoryId: categoryId),
        throwsA(isA<FirebaseException>()), // Expect a FirebaseException
      );

      // Verify that the relevant Firestore calls were made.
      verify(mockFirebaseFirestore.collection("products")).called(1);
      verify(mockCollectionReference.where("category_id", isEqualTo: categoryId)).called(1);
      verify(mockQuery.get()).called(1);
    });
  });

  group('GetProductsUseCase', () {
    const String testCategoryId = 'testCat123';
    final ProductEntity productEntity1 = ProductEntity(
      id: 'p1',
      name: 'Entity Product 1',
      categoryId: 'testCat123',
      price: 100.0,
      description: 'Desc 1',
      imageUrl: 'url1',
    );
    final ProductEntity productEntity2 = ProductEntity(
      id: 'p2',
      name: 'Entity Product 2',
      categoryId: 'testCat123',
      price: 200.0,
      description: 'Desc 2',
      imageUrl: 'url2',
    );
    final List<ProductEntity> productEntities = [productEntity1, productEntity2];

    test('should return DataSuccess with list of ProductEntity on success', () async {
      // Arrange
      when(mockProductRepository.getProducts(categoryId: testCategoryId))
          .thenAnswer((_) async => DataSuccess(productEntities));

      // Act
      final result = await getProductsUseCase.call(categoryId: testCategoryId);

      // Assert
      expect(result, isA<DataSuccess<List<ProductEntity>>>());
      expect(result.data, productEntities);
      verify(mockProductRepository.getProducts(categoryId: testCategoryId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return DataFailed with error on failure', () async {
      // Arrange
      final Exception error = Exception('Failed to fetch products');
      when(mockProductRepository.getProducts(categoryId: testCategoryId))
          .thenAnswer((_) async => DataFailed(error));

      // Act
      final result = await getProductsUseCase.call(categoryId: testCategoryId);

      // Assert
      expect(result, isA<DataFailed<List<ProductEntity>>>());
      expect(result.error, error);
      verify(mockProductRepository.getProducts(categoryId: testCategoryId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return DataFailed with FirebaseException on Firestore error', () async {
      // Arrange
      final FirebaseException firebaseError = FirebaseException(plugin: 'Firestore', message: 'Permission Denied');
      when(mockProductRepository.getProducts(categoryId: testCategoryId))
          .thenAnswer((_) async => DataFailed(firebaseError));

      // Act
      final result = await getProductsUseCase.call(categoryId: testCategoryId);

      // Assert
      expect(result, isA<DataFailed<List<ProductEntity>>>());
      expect(result.error, isA<FirebaseException>());
      expect((result.error as FirebaseException).message, 'Permission Denied');
      verify(mockProductRepository.getProducts(categoryId: testCategoryId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
