import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxServices extends GetxController {
  RxString location = 'mardan'.obs;
  RxBool search = false.obs;
  RxBool isLoading = false.obs;

  //city search controller
  Rx<TextEditingController> searchController = TextEditingController().obs;

  searchOnOff() {
    if (search.value) {
      location.value = searchController.value.text;
      search.value = false;
      searchController.value.clear();
    } else {
      search.value = true;
    }
    return search;
  }
}
