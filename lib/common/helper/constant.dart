class AppConstant {
  static const String APP_NAME = 'Safe Gate';
}

class HttpConstant {
  static const String CONNECT_ERROR = 'Không có kết nối. Vui lòng thử lại sau';
  static const String UNKNOWN = 'Đã có lỗi xảy ra. Vui lòng thử lại sau';
  static const String TIME_OUT = 'Hết hạn yêu cầu. Vui lòng thử lại sau';
  static const String BAD_GATEWAY = 'Server bận. Vui lòng thử lại sau';

  static const String NOT_FOUND = 'Không tìm thấy nội dung yêu cầu. Vui lòng thử lại sau';
  static const String FORBIDDEN = 'Truy cập bị hạn chế. Vui lòng thử lại sau';
  static const String AUTHENTICATION = 'Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại';
  static const String NO_CONTENT = 'Trống';

  static const int CONNECT_TIMEOUT = 20000;
  static const int RECEIVE_TIMEOUT = 20000;
  static const String CONTENT_TYPE = 'application/json';

  // static const String BASE_URL = 'https://virtserver.swaggerhub.com';
  // static const String BASE_URL = 'http://device.safegate.vn';
  static const String STATIC_BASE_URL = 'http://192.168.2.11';
  static const String BASE_URL = 'http://192.168.2.11';
  static const String DEVICE_ID = '12358695456';
  static const String DEVICE_ID_2 = '72622743108161618';
  static const String DEVICE_ID_3 = '72622743041052754';
}

class CodeConstant {
  static const int UNKNOWN = 1001;
  static const int CONNECT_ERROR = 1002;
  static const int VALIDATE = 1003;

  static const int NO_CONTENT = 204;
  static const int AUTHENTICATION = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int TIME_OUT = 408;
  static const int ERROR = 500;
  static const int BAD_GATEWAY = 502;
  static const int OK = 200;
}

class LanguageCodeConstant {
  static const String VI = 'vi';
  static const String EN = 'en';
}

class LanguageCountryConstant {
  static const String VI = 'VN';
  static const String EN = 'US';
}

class ThemeModeConstant {
  static const String DARK = 'dark';
  static const String LIGHT = 'light';
}

class TypeDialog {
  static const String LANGUAGE = 'language';
  static const String THEME = 'theme';
}

class UserEditType {
  static const String ONLY_PICK_MODE = 'ONLY_PICK_MODE';
  static const String PICK_MODE_AND_DEVICE = 'PICK_MODE_AND_DEVICE';
}

class UserDeviceStatus {
  static const int NOT_CONNECT = 0;
  static const int CONNECT = 1;
}

class OtpType {
  static const String OTP_SIGN_UP = '0'; // Otp cho đăng ký
  static const String OTP_RESET_PASSWORD = '1'; // Otp cho reset mật khẩu
  static const String OTP_LOGIN = '2'; // Otp cho login
}

class HistoryType {
  static const String ACCESS = '0'; // Lịch sử truy cập
  static const String VIOLATION = '1'; // Lịch sử vi phạm
}

class ModeType {
  static const String LIMIT = 'deny';
  static const String UN_LIMIT = 'allow';
  static const String MONITOR = 'report';
}

class ArenaCode {
  static const String VIETNAM = 'VN'; // Lịch sử truy cập
  static const String UK = 'UK'; // Lịch sử vi phạm
  static const String US = 'US'; // Lịch sử vi phạm
}

class DNSMode {
  static const String CHILD = 'child';
  static const String ADULT = 'adult';
}

class CronWeekDay {
  static const String MON = 'MON';
  static const String TUE = 'TUE';
  static const String WED = 'WED';
  static const String THU = 'THU';
  static const String FRI = 'FRI';
  static const String SAT = 'SAT';
  static const String SUN = 'SUN';
}

class UserStatus {
  static const String ACTIVE = 'ACTIVE';
  static const String PAUSE = 'PAUSE';
  static const String OFFLINE = 'OFFLINE';
}

class DeviceStatus {
  static const String ALL = 'all';
  static const String ONLINE = 'online';
  static const String IGNORE = 'ignore';
  static const String MANAGED = 'managed';
  static const String UNMANAGED = 'unmanaged';
  static const String UNKNOWN = 'unknown';
}

class ReportBy {
  static const String TODAY = 'TODAY';
  static const String YESTERDAY = 'YESTERDAY';
  static const String THIS_WEEK = 'THIS_WEEK';
  static const String LAST_WEEK = 'LAST_WEEK';
  static const String OPTION = 'OPTION';
}

class DeviceType {
  static const int NONE = 0;
  static const int MANAGED = 2;
}
