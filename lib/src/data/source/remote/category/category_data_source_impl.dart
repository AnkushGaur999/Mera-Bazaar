import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/category/category_model.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';


class CategoryDataSourceImpl extends CategoryDataSource {
  final DioClient dioClient;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  CategoryDataSourceImpl({required this.dioClient});

  @override
  Future<List<CategoryModel>> getCategory() async {
    try {
      final result =
          await _fireStore.collection("categories").orderBy("name").get();

      return result.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
    } catch (e) {
      rethrow;
    }
  }

}
