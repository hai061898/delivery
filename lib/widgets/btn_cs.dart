// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors


part of 'widgets.dart';

class BtnSocial extends StatelessWidget {

  final IconData icon;
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isBorder; 

  const BtnSocial({ 
    required this.icon, 
    required this.text, 
    this.onPressed,
    this.backgroundColor = const Color(0xffF5F5F5),
    this.textColor = Colors.black,
    this.isBorder = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onPressed,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: isBorder ? Border.all(color: Colors.grey, width: .7) : null,
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Row(
            children: [
              SizedBox(width: 30.0),
              Icon(icon, color: isBorder ? Colors.black87 : Colors.white ),
              SizedBox(width: 20.0),
              TextCustom(text: text, color: textColor, fontSize: 17 )
            ],
          ),
        ),
      ),
    );
  }
}