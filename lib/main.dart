import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_pagination/images_view_model.dart';

import 'images_list_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  ImagesViewModel imagesViewModel = Get.put(ImagesViewModel());

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Demo'),
      ),
      body: GetBuilder(
          init: imagesViewModel,
          builder: (ImagesViewModel value) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!value.isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        value.loadData();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: value.items.length,
                      itemBuilder: (context, index) {
                        return ImageDataWidget(value.items[index]);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: value.isLoading ? 50.0 : 0,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class ImageDataWidget extends StatelessWidget {
  final ImagesListModel item;

  const ImageDataWidget(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(height: 100, child: Image.network(item.thumbnailUrl!)),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(item.title!),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
