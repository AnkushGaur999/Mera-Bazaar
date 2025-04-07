import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/product/products_response.dart';
import 'package:mera_bazaar/src/data/source/remote/product/product_data_source.dart';

class ProductDataSourceImpl extends ProductDataSource {
  final DioClient dioClient;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ProductDataSourceImpl({required this.dioClient});

  @override
  Future<List<ProductResponse>> getProducts({required String type}) async {
    final List<ProductResponse> products = [];

    final productDocs = await _fireStore.collection("products").get();

    for (var i = 0; i < productDocs.docs.length; i++) {
      products.add(ProductResponse.fromJson(productDocs.docs[i].data()));
    }

    return products;
  }
}
