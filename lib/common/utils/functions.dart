class Functions {
  static String timeDifferenceInText(Duration duration) {
    int inHours = duration.inHours;
    // If it's less than 1 hour, represent it as minutes
    if (inHours < 1) return '${duration.inMinutes}  분전';
    // If it's greater than 1 hour, represent it as hours
    if (inHours > 1 && inHours < 24) return '$inHours  시간 전';
    // If it's greater than 24 hours, represent it as days
    if (inHours > 24) return '${duration.inDays}  일전';

    // Default behavior or error behavior is hours ago
    return '$inHours hours ago';
  }
}
