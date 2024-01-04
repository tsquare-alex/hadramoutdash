import 'dart:math';

extension StringReverse on String {
  String reverse() {
    return split('').reversed.join();
  }
}

extension StringWords on String {
  int countWords() {
    var words = split(RegExp(r'\s+'));
    return words.where((w) => w.isNotEmpty).length;
  }
}

extension StringEmail on String {
  bool isEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

extension StringPhoneNumber on String {
  bool isPhoneNumber() {
    // regular expression to match phone number
    final phoneNumberRegex = RegExp(
        r'^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$');
    return phoneNumberRegex.hasMatch(this);
  }
}

extension StringNumeric on String {
  bool isNumeric() {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }
}

extension StringAlpha on String {
  bool isAlpha() {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }
}

extension DateTimeToday on DateTime {
  bool isToday() {
    DateTime now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}

extension DateTimeTimeAgo on DateTime {
  String timeAgo() {
    Duration duration = DateTime.now().difference(this);
    if (duration.inDays >= 365) {
      int years = (duration.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
    if (duration.inDays >= 30) {
      int months = (duration.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    }
    if (duration.inDays > 0) {
      return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ago';
    }
    if (duration.inHours > 0) {
      return '${duration.inHours} hour${duration.inHours > 1 ? 's' : ''} ago';
    }
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute${duration.inMinutes > 1 ? 's' : ''} ago';
    }
    if (duration.inSeconds > 0) {
      return '${duration.inSeconds} second${duration.inSeconds > 1 ? 's' : ''} ago';
    }
    return 'Just now';
  }
}

extension ListSorted on List {
  bool isSorted() {
    for (int i = 0; i < length - 1; i++) {
      if (this[i] > this[i + 1]) {
        return false;
      }
    }
    return true;
  }
}

extension ListRandom on List {
  dynamic random({int? seed}) {
    var random = Random(seed);
    return this[random.nextInt(length)];
  }
}

extension StringCapitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension StringAscii on String {
  bool isAscii() {
    return RegExp(r'^[\x00-\x7F]+$').hasMatch(this);
  }
}
