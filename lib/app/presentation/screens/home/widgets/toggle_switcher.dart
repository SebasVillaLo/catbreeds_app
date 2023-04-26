import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';

class ToggleSwitcher extends StatelessWidget {
  const ToggleSwitcher({
    super.key,
    this.width = 50.0,
    this.height = 30.0,
  });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isActive = themeProvider.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        isActive = !isActive;
        themeProvider.toggleTheme();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.6),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: (width - height / 2) / 1.5,
              height: height - 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.black : Colors.white,
              ),
              child: !isActive
                  ? const Icon(
                      Icons.wb_sunny_outlined,
                      size: 14,
                    )
                  : const Icon(
                      Icons.nightlight_round,
                      // color: white,
                      size: 14,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
