import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/home/get_carousels_response.dart';
import 'package:mera_bazaar/src/data/source/remote/home/home_data_source.dart';

class HomeDataSourceImpl extends HomeDataSource {
  final DioClient dioClient;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  HomeDataSourceImpl({required this.dioClient});

  @override
  Future<List<GetCarouselsResponse>> getCarousels() async {
    final response = await _fireStore.collection("carousels").get();

    return response.docs
        .map((e) => GetCarouselsResponse.fromJson(e.data()))
        .toList();
  }
}
