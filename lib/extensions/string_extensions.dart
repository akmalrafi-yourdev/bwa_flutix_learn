part of 'extensions.dart';

extension StringExtension on String {
  bool isDigit(int index) =>
      this.codeUnitAt(index) >= 48 && this.codeUnitAt(index) <= 57;
  // 48 dan 57 adalah kode ASCII untuk angka 0-9
}
