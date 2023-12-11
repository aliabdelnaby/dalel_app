import '../models/data_model.dart';
import 'custom_data_list_view_item.dart';
import 'package:flutter/material.dart';

class CustomDataListView extends StatelessWidget {
  const CustomDataListView({
    super.key,
    required this.dataList,
    required this.routePath,
  });

  final List<DataModel> dataList;
  final String routePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dataList.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return CustomDataListViewItem(
            model: dataList[index],
            routePath: routePath,
          );
        },
      ),
    );
  }
}
