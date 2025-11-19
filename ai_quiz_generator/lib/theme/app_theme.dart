import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryApp = Colors.orange;
  static Color primaryAppLight = Colors.orange.shade100;
  static Color lightWhite = Colors.grey.shade100;
  static Color primaryAppExtraLight = Colors.orange.shade50;

  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryAppLight,
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: lightWhite,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryApp,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightWhite,
        surfaceTintColor: lightWhite,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: primaryApp,
        indicatorColor: primaryApp,
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: WidgetStateColor.transparent,
        splashFactory: NoSplash.splashFactory,
        dividerColor: lightWhite,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryApp,
        foregroundColor: lightWhite,
      ),
      cardTheme: CardThemeData(
        color: lightWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 6,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryAppLight,
        textTheme: ButtonTextTheme.primary,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppTheme.primaryAppExtraLight,
        selectedColor: AppTheme.primaryAppLight,
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: lightWhite,
        elevation: 6.0,
        surfaceTintColor: primaryAppExtraLight,
        textStyle: TextStyle(color: lightWhite),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: primaryAppExtraLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryAppLight),
        ),
        labelStyle: const TextStyle(color: primaryApp),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppTheme.primaryApp),
          borderRadius: BorderRadius.circular(20.0),
        ),
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide(color: AppTheme.primaryAppLight),
          borderRadius: BorderRadius.circular(20.0),
        ),
        childrenPadding: const EdgeInsets.all(10.0),
        collapsedBackgroundColor: primaryAppExtraLight,
        backgroundColor:
            primaryAppExtraLight, //background color of children area
      ),
      splashColor: lightWhite,
      iconTheme: const IconThemeData(color: Colors.black),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: primaryAppExtraLight,
        showDragHandle: true,
        surfaceTintColor: primaryAppLight,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppTheme.primaryAppExtraLight,
      ),
    );
  }
}
