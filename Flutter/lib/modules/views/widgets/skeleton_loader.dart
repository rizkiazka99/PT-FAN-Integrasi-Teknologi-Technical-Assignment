import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:flutter/material.dart';

class SkeletonLoader extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonLoader({
    super.key, 
    this.height = 125, 
    this.width = 0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width == 0 ? MediaQuery.of(context).size.width : width,
      margin: EdgeInsets.only(
        top: width == 120 || width == 147 ? 0 : 12,
        bottom: width == 120 ? 12 : 0,
        left: 12,
        right: 12
      ),
      child: SkeletonAnimation(
        shimmerColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        shimmerDuration: 1000,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: backgroundColorPrimary)
            ]
          ),
        ),
      ),
    );
  }
}