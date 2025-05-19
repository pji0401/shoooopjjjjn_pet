import 'package:flutter/material.dart';

class ModalSheet {
  static Future<void> showModalSheetView({
    required BuildContext context,
    required List<Widget> children,
    double height = 375, 
    Color backgroundColor = Colors.white,
    double borderRadius = 20,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent, 
      isScrollControlled: true, 
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets, 
          child: Container(
            width: double.infinity,
            height: height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _modalBar(context),
                const SizedBox(height: 24),
                Flexible( 
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0), 
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: children,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), 
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _modalBar(BuildContext context) {
  return FractionallySizedBox(
    widthFactor: 0.1,
    child: Container(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xffc4c4c7),
          borderRadius: const BorderRadius.all(Radius.circular(2.5)),
        ),
      ),
    ),
  );
}