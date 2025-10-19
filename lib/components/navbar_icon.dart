import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavbarIcon extends StatelessWidget {
  final String iconName;
  final Color? color;

  const NavbarIcon({super.key, required this.iconName, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      width: 24,
      height: 24,
      fit: BoxFit.scaleDown,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}
