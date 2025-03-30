import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mera_bazaar/src/core/constants/app_files.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/category/category_model.dart';
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart';

class CategoryDataSourceImpl extends CategoryDataSource{

  final DioClient dioClient;

  CategoryDataSourceImpl({required this.dioClient});

  @override
  Future<List<CategoryModel>> getCategory() async{
    Future.delayed(const Duration(seconds: 2));

    final jsonFile = await rootBundle.loadString(AppFiles.categories);

    final categories = jsonDecode(jsonFile);

    return categories["categories"]
        .map<CategoryModel>((e) => CategoryModel.fromJson(e))
        .toList();
  }

}