class TimestringToDateTime {
  static DateTime encode(String raw) {
    List<String> split1 = raw.split("T");
    String dateRaw = split1[0];
    List<String> split2 = split1[1].split(".");
    String timeRaw = split2[0];


    return DateTime.parse("$dateRaw ${timeRaw}Z");
  }
}