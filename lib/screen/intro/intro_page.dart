// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const TextCustom(
                text: 'Star ',
                color: Color(0xff0C6CF2),
                fontWeight: FontWeight.w500,
                fontSize: 25),
            const TextCustom(
                text: 'Food', fontSize: 25, fontWeight: FontWeight.w500),
          ],
          
        ),
         backgroundColor: Colors.white,
        elevation: 0,
      ),
       body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              height: 350,
              width: size.width,
              child: SvgPicture.asset('Assets/delivery.svg'),
            ),
            Column(
              children: [
                BtnSocial(
                  icon: FontAwesomeIcons.google, 
                  text: 'Sign up with Google',
                  backgroundColor: Colors.white,
                  isBorder: true,
                ),
                SizedBox(height: 15.0),
                BtnSocial(
                  icon: FontAwesomeIcons.facebook, 
                  text: 'Sign up with Facebook',
                  backgroundColor: Color(0xff3b5998),
                  textColor: Colors.white,
                ),
                SizedBox(height: 15.0),
                BtnSocial(
                  icon: FontAwesomeIcons.envelope,
                  text: 'Sign up with an Email ID',
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(context, routeFrave(page: RegisterClientPage())),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 1,
                      width: 150,
                      color: Colors.grey[300]
                    ),
                    TextCustom(text: 'Or', fontSize: 16, ),
                    Container(
                      height: 1,
                      width: 150,
                      color: Colors.grey[300]             
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: BtnCustom(
                    text: 'Login',
                    fontWeight: FontWeight.w500,
                    borderRadius: 10.0,
                    height: 50,
                    fontSize: 20,
                    onPressed: () => Navigator.push(context, routeFrave(page: LoginPage())),
                  ),
                ),
                SizedBox(height: 20.0)
              ],
            )
          ],
        ),
      ),
    );
  }
}
