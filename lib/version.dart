import 'dart:math';

/// Model to represent a version
class Version implements Comparable<Version> {
  static RegExp versionRegExp = RegExp(
      r"^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$");

  final String version;

  /// The version is passed as string in the format Major.Minor.Micro (Eg. 1.0.0)
  Version({required this.version}) {
    if (!versionRegExp.hasMatch(version)) {
      throw FormatException();
    }
  }

  @override
  int compareTo(Version other) {
    List<int> versionParts = version.split(".").map((part) => int.parse(part)).toList();
    List<int> otherParts = other.version.split(".").map((part) => int.parse(part)).toList();

    int numberOfParts = max(versionParts.length, otherParts.length);

    for (var index = 0; index < numberOfParts; index++) {
      int versionPart = index < versionParts.length ? versionParts[index] : 0;
      int otherPart = index < otherParts.length ? otherParts[index] : 0;

      if (versionPart < otherPart) {
        return -1;
      }

      if (versionPart > otherPart) {
        return 1;
      }
    }

    return 0;
  }

  @override
  String toString() {
    return version;
  }
}
