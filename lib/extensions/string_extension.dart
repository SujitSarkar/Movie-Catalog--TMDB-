extension StringExtensions on String {
  DateTime toDate() {
    try {
      return DateTime.parse(this);
    } catch (error) {
      return DateTime.now();
    }
  }
}
