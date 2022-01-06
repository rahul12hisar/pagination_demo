import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:list_pagination/images_list_model.dart';

class ImagesViewModel extends GetxController {
  var isLoadingValue = false.obs;

  var page = 0;

  bool get isLoading => isLoadingValue.value;

  var itemsList = <ImagesListModel>[].obs;

  get items => itemsList;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    isLoadingValue.value = true;
    update();
    page = page + 1;
    getData().then((value) {
      itemsList.value.addAll(value);
      isLoadingValue.value = false;
      update();
    });
  }

  Future<List<ImagesListModel>> getData() async {
    var url = 'https://jsonplaceholder.typicode.com/photos?_page=$page?_limit=10';
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => ImagesListModel.fromJson(x))
            .toList();
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
      }
    } catch (error) {
      print(error);
    }
    throw {};
  }
}
