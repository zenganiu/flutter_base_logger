enum NetType { http, socket }

extension DcmbLoggerBWM on NetType {
  String printFlag() {
    switch (this) {
      case NetType.http:
        return "[http]";
      case NetType.socket:
        return "[socket]";
    }
  }

  String tabFlag() {
    switch (this) {
      case NetType.http:
        return "[http]";
      case NetType.socket:
        return "[socket]";
    }
  }
}
