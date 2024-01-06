import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,required this.buttonName,required this.onTap});
   VoidCallback onTap;
   String buttonName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
              buttonName,
            style: TextStyle(
              color: Color(0xff2B475E),
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),


          ),
        ),
      ),
    );
  }
}
