// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/models/response/category_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ListCategories extends StatelessWidget {
  final List<Category> listCategory;

  const ListCategories({required this.listCategory});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      physics: BouncingScrollPhysics(),
      itemCount: listCategory.length,
      itemBuilder: (_, i) => Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                        color: ColorsCustom.primaryColor, width: 4.5)),
              ),
              SizedBox(width: 20.0),
              TextCustom(text: listCategory[i].category),
            ],
          ),
        ),
      ),
    );
  }
}
