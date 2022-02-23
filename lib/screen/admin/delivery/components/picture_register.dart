// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PictureRegistre extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: Colors.grey[300]!),
          shape: BoxShape.circle),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => modalPictureRegister(
            ctx: context,
            onPressedChange: () async {
              Navigator.pop(context);
              final XFile? imagePath =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (imagePath != null)
                userBloc.add(OnSelectPictureEvent(imagePath.path));
            },
            onPressedTake: () async {
              Navigator.pop(context);
              final XFile? photoPath =
                  await _picker.pickImage(source: ImageSource.camera);
              userBloc.add(OnSelectPictureEvent(photoPath!.path));
            }),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => state.pictureProfilePath == ''
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wallpaper_rounded,
                        size: 60, color: ColorsCustom.primaryColor),
                    SizedBox(height: 10.0),
                    TextCustom(text: 'Picture', color: Colors.black45)
                  ],
                )
              : Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(state.pictureProfilePath)))),
                ),
        ),
      ),
    );
  }
}
