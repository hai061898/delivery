// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:da/bloc/auth/auth_bloc.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/controllers/category_controller.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/category_response.dart';
import 'package:da/services/url_api.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/list_product.dart';

class ClientHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(URLS.BASE_URL +
                                  authBloc.state.user!.image.toString()))),
                    ),
                    SizedBox(width: 8.0),
                    TextCustom(
                        text: DateCustom.getDateFrave() +
                            ', ${authBloc.state.user!.firstName}',
                        fontSize: 17,
                        color: ColorsFrave.secundaryColor),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context, routeCustom(page: CartClientPage())),
                  child: Stack(
                    children: [
                      Container(
                        child: Icon(Icons.shopping_bag_outlined, size: 30),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 5,
                        child: Container(
                            height: 20,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Color(0xff0C6CF2),
                                shape: BoxShape.circle),
                            child: Center(
                                child: BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) => TextCustom(
                                        text: state.quantityCart.toString(),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)))),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Container(
                padding: EdgeInsets.only(right: 50.0),
                child: TextCustom(
                    text: 'What do you want eat today?',
                    fontSize: 28,
                    maxLine: 2,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(15.0)),
                  child:
                      Icon(Icons.place_outlined, size: 38, color: Colors.grey),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(text: 'Address'),
                    InkWell(
                      onTap: () => Navigator.push(
                          context, routeCustom(page: ListAddressesPage())),
                      child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) => TextCustom(
                                text: (state.addressName != '')
                                    ? state.addressName
                                    : 'without direction',
                                color: ColorsCustom.primaryColor,
                                fontSize: 17,
                                maxLine: 1,
                              )),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20.0),
            FutureBuilder<List<Category>>(
              future: categoryController.getAllCategories(),
              builder: (context, snapshot) {
                final List<Category>? category = snapshot.data;

                return !snapshot.hasData
                    ? ShimmerCustom()
                    : Container(
                        height: 45,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: category!.length,
                          itemBuilder: (context, i) => InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => Navigator.push(
                                context,
                                routeCustom(
                                    page: SearchForCategoryPage(
                                        idCategory: category[i].id,
                                        category: category[i].category))),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10.0),
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff5469D4).withOpacity(.1),
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: TextCustom(text: category[i].category),
                            ),
                          ),
                        ),
                      );
              },
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustom(
                    text: 'Populer Items',
                    fontSize: 21,
                    fontWeight: FontWeight.w500),
                TextCustom(
                    text: 'See All',
                    color: ColorsCustom.primaryColor,
                    fontSize: 17)
              ],
            ),
            SizedBox(height: 20.0),
            ListProducts(),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationCustom(0),
    );
  }
}
