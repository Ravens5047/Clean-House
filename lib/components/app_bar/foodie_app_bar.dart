import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';

class FoodieAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FoodieAppBar({
    super.key,
    Icon? icon,
    required this.title,
    this.color,
  });
  final String title;
  final Color? color;

  @override
  State<FoodieAppBar> createState() => _FoodieAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(86.0);
}

class _FoodieAppBarState extends State<FoodieAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
          top: MediaQuery.of(context).padding.top + 6.0, bottom: 12.0),
      child: Text(
        widget.title,
        style: AppStyle.h22Normal,
      ),
    );
  }
}
