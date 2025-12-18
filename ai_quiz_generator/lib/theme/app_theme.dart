import 'package:flutter/material.dart';

class AppTheme {
  // Cold blue color palette
  static const Color primaryApp = Color(0xFF4169E1); // Royal Blue
  static Color primaryAppLight = const Color(0xFF87CEEB); // Sky Blue
  static Color lightWhite = const Color(
    0xFFF0F4F8,
  ); // Light blue-gray background
  static Color primaryAppExtraLight = const Color(
    0xFFE6F2FF,
  ); // Very light blue
  static const Color cardBackground = Color(0xFFFFFFFF); // White cards

  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryAppLight,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: lightWhite,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryApp,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: cardBackground,
        surfaceTintColor: cardBackground,
        titleTextStyle: const TextStyle(
          color: Color(0xFF2C3E50),
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
        elevation: 0,
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
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4,
        shadowColor: primaryApp.withValues(alpha: 0.1),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryApp,
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
        color: cardBackground,
        elevation: 6.0,
        surfaceTintColor: primaryAppExtraLight,
        textStyle: const TextStyle(color: Color(0xFF2C3E50)),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: primaryAppExtraLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: primaryAppLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: primaryApp, width: 2),
        ),
        labelStyle: TextStyle(color: primaryApp),
        filled: true,
        fillColor: cardBackground,
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
      splashColor: primaryAppLight.withValues(alpha: 0.2),
      iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: cardBackground,
        showDragHandle: true,
        surfaceTintColor: primaryAppLight,
      ),
      dialogTheme: DialogThemeData(backgroundColor: cardBackground),
    );
  }
}
