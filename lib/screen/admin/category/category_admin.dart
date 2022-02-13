// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:da/controllers/category_controller.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/category_response.dart';
import 'package:da/screen/admin/category/add_category_admin.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'components/list_category.dart';

class CategoriesAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextCustom(text: 'Categories'),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsCustom.primaryColor, size: 17),
              TextCustom(
                text: 'Back',
                fontSize: 17,
                color: ColorsCustom.primaryColor,
              )
            ],
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context, routeCustom(page: AddCategoryAdminPage())),
              child: TextCustom(
                  text: 'Add', color: ColorsCustom.primaryColor, fontSize: 17))
        ],
      ),
      body: FutureBuilder<List<Category>>(
          future: categoryController.getAllCategories(),
          builder: (context, snapshot) => !snapshot.hasData
              ? Center(
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      TextCustom(text: 'Loading Categories...')
                    ],
                  ),
                )
              : ListCategories(listCategory: snapshot.data!)),
    );
  }
}
