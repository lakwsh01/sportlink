import 'package:flutter/material.dart';

class MapViewIconButton extends StatelessWidget {
  final IconData icon;
  final IconThemeData? theme;
  final VoidCallback onTap;
  final Color? backgroundColor;
  const MapViewIconButton(
      {required this.icon,
      this.backgroundColor,
      this.theme,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    // final radius = BorderRadius.circular(4);
    const shape = CircleBorder();
    return IconTheme(
        data: theme ?? const IconThemeData(color: Colors.white, size: 24),
        child: Material(

            // borderRadius: radius,
            elevation: 5,
            shape: shape,
            color: backgroundColor ?? Colors.blueGrey,
            child: InkWell(
                customBorder: shape,
                // borderRadius: radius,
                onTap: onTap,
                child: Container(
                    padding: const EdgeInsets.all(8), child: Icon(icon)))));
  }
}
