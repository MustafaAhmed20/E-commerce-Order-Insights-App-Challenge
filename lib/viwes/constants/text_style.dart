part of 'constants.dart';

/// The app text styles
abstract class AppTextStyle {
  /// Fonts
  static final textStyle40 = _createTextStyle(fontSize: 40.sp);
  static final textStyle25 = _createTextStyle(fontSize: 25.sp);
  static final textStyle24 = _createTextStyle(fontSize: 24.sp);
  static final textStyle22 = _createTextStyle(fontSize: 22.sp);
  static final textStyle20 = _createTextStyle(fontSize: 20.sp);
  static final textStyle18 = _createTextStyle(fontSize: 18.sp);

  static final textStyle17 = _createTextStyle(fontSize: 17.sp);
  static final textStyle16 = _createTextStyle(fontSize: 16.sp);
  static final textStyle15 = _createTextStyle(fontSize: 15.sp);
  static final textStyle14 = _createTextStyle(fontSize: 14.sp);
  static final textStyle13 = _createTextStyle(fontSize: 13.sp);
  static final textStyle12 = _createTextStyle(fontSize: 12.sp);

  static final textStyle11 = _createTextStyle(fontSize: 11.sp);
  static final textStyle10 = _createTextStyle(fontSize: 10.sp);
  static final textStyle9 = _createTextStyle(fontSize: 9.sp);
  static final textStyle8 = _createTextStyle(fontSize: 8.sp);
  static final textStyle7 = _createTextStyle(fontSize: 7.sp);
  static final textStyle6 = _createTextStyle(fontSize: 6.sp);
  static final textStyle5 = _createTextStyle(fontSize: 5.sp);
}

/// Font families
abstract class AppFontsFamilies {
  static final TextTheme defaultTheme = GoogleFonts.readexProTextTheme();
  static final TextStyle defaultTextStyle = GoogleFonts.readexPro();

  static final TextStyle cairoTextStyle = GoogleFonts.cairo();
  // static final TextStyle poppinsTextStyle = GoogleFonts.poppins();
}

TextStyle _createTextStyle({
  required double fontSize,
  TextStyle? textStyle,
  FontWeight fontWeight = FontWeight.w400,
  Color? color = Colors.black,
}) {
  TextStyle usedTextStyle = textStyle ?? AppFontsFamilies.defaultTextStyle;

  return usedTextStyle.copyWith(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
