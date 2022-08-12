import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';

const Map<String, String> en = {
    // datetime
  KeyLanguage.mon: 'Mon',
  KeyLanguage.tue: 'Tue',
  KeyLanguage.wed: 'Wed',
  KeyLanguage.thu: 'Thu',
  KeyLanguage.fri: 'Fri',
  KeyLanguage.sat: 'Sat',
  KeyLanguage.sun: 'Sun',
  KeyLanguage.month: 'Month',
  KeyLanguage.year: 'Year',
  KeyLanguage.device: 'Devices',
  KeyLanguage.login: 'Login',
  KeyLanguage.noBiometric: 'noBiometric',
  KeyLanguage.noAccount: "Don't have an account? ",
  KeyLanguage.unmanaged_device: 'Unmanaged devices',
  KeyLanguage.connect_time: 'Connect time',
  // account
  KeyLanguage.doSignUpAccount: 'Do you account?',
  KeyLanguage.signUp: 'Register',
  KeyLanguage.forgotPassword: 'Forgot password?',
  KeyLanguage.exit_app: 'Do you sure want to exit?',
  KeyLanguage.sendOtpAgain: 'Send OTP again in: ',
  // account screen
  KeyLanguage.avatar_name: 'Girl',
  KeyLanguage.confirmPwd: 'Confirm password',
  // action
  KeyLanguage.onback: 'Back',
  KeyLanguage.add: 'Add',
  KeyLanguage.apply: 'Apply',
  KeyLanguage.send_request: 'Send request',
  KeyLanguage.exit: 'Cancel',
  KeyLanguage.resume: 'Next',
  // status
  KeyLanguage.success: 'Success',
  KeyLanguage.nodata: 'No data',
  KeyLanguage.repeat: 'Repeat',
  KeyLanguage.assign_connection:
      'Automatically assign a new connection to the group',
  KeyLanguage.new_connection: 'Request an approval upon new connection',
  // widget wifi
  KeyLanguage.encode: 'Encode',
  KeyLanguage.wifi_name: 'Wifi name (SSID)',
  KeyLanguage.set_device_name: 'Device name',
  KeyLanguage.device_info: 'Device Information',
  KeyLanguage.scan_in_network: 'Scan in network',
  KeyLanguage.application_initialization: 'Application initialization',
  KeyLanguage.device_connecting: 'Device connecting',
  KeyLanguage.network_scanning: 'Network scanning',
  KeyLanguage.wi_fi_configuration: 'Wi-Fi Configuration',
  KeyLanguage.advanced_option: 'Advanced option',
  KeyLanguage.frequency: 'Frequency',
  KeyLanguage.network_bandwidth: 'Bandwidth',
  KeyLanguage.hind_wifi: 'Hind Wifi',
  KeyLanguage.access_permission: 'Permission to use',
  KeyLanguage.collapse: 'Collapse',
  KeyLanguage.device_code: 'Device code',
    // widget menu
  KeyLanguage.group: 'Group',
  KeyLanguage.app_a_web: 'Apps and web',
  KeyLanguage.deny: 'Deny',
  KeyLanguage.wifi_type: 'Wifi type',
  KeyLanguage.hello: 'Hello,',
  KeyLanguage.notme: 'Not me',
  KeyLanguage.update: 'Update',
  KeyLanguage.enterPhoneNumber: 'Enter Phone Number',
  KeyLanguage.version: 'Software version',
  KeyLanguage.use_service: 'The service is being built',
  KeyLanguage.detail_info: 'Details',
  KeyLanguage.device_type: 'Device type:',
  KeyLanguage.soft_update: 'Software update',
  KeyLanguage.upgrade: 'Upgrade',
  KeyLanguage.re_new: 'Renew',
  KeyLanguage.info_connect: 'Contact infomation',
  KeyLanguage.device_name: 'Device name:',
  KeyLanguage.updatePwdSuccess: 'Password successfully changed',
  KeyLanguage.managed_device: 'Managed device',
  KeyLanguage.device_config: 'Device configuration',
  KeyLanguage.pause: 'Pause',
  KeyLanguage.auto_shell: 'Auto Protection',
  KeyLanguage.safe_access: 'Safe Access',
  KeyLanguage.connect_config: 'Connection configuration',
  KeyLanguage.network_config: 'Network configuration',
  KeyLanguage.security_device: 'Device security',
  KeyLanguage.too_short: 'Use at least 8 characters',
  KeyLanguage.isNotFormatPwd:
      'Password is combine uppercase, lowercase letters, numbers and special characters',
  KeyLanguage.violation_of_the_day: 'Violation of the day',
  KeyLanguage.usage_time: 'Usage time',
  KeyLanguage.total_number_of_devices: 'Total number of devices',
  KeyLanguage.phoneSign: 'Registered phone number',
  KeyLanguage.used: 'Used',
  KeyLanguage.search: 'Search',
  KeyLanguage.otp_verify: 'OTP Verify',
  KeyLanguage.otp_send_notify: 'OTP message has been sent to the phone number',
  KeyLanguage.notPhone: 'Invalid phone number',
  KeyLanguage.isNotEmpty: 'This field is required',
  KeyLanguage.reset_pwd: 'Reset Password',
  KeyLanguage.assetphoneNumber: 'Phone number (*)',
  KeyLanguage.password: 'Password',
  KeyLanguage.assertPwd: 'Password (*)',
  KeyLanguage.assertRepeatPwd: 'Confirm Password (*)',
  KeyLanguage.newMemberEquipment: 'New member equipment',
  KeyLanguage.disconnect: 'Disconnect',
  KeyLanguage.save: 'Save',
  KeyLanguage.signAccount: 'Register Account',
  KeyLanguage.camera: 'Camera',
  KeyLanguage.request_reset_pwd: 'Password reset request',
  KeyLanguage.image_gallery: 'Image Gallery',
  KeyLanguage.phone: 'Phone',
  KeyLanguage.laptop: 'laptop',
  KeyLanguage.desktop: 'Desktop',
  KeyLanguage.tv: 'TV',
  KeyLanguage.device_used: 'Devices in use',
  KeyLanguage.userProfile: 'User profile',
  KeyLanguage.userProfiles: 'User profiles',
  KeyLanguage.timeUsed: 'Time used',
  KeyLanguage.closest_access: 'Accessed',
  KeyLanguage.history: 'History',
  KeyLanguage.setting: 'Setting',
  KeyLanguage.violations: 'Violations',
  KeyLanguage.language_vi: 'Vietnamese',
  KeyLanguage.language_en: 'English',
  KeyLanguage.my_info: 'Personal information',
  KeyLanguage.new_password: 'New password',
  KeyLanguage.renew_password: 'Confirm password',
  KeyLanguage.change_password: 'Change password',
  KeyLanguage.current_password: 'Current password',
  KeyLanguage.language: 'Language',
  KeyLanguage.user_interface: 'User interface',
  KeyLanguage.alert_config: 'Alert configuration',
  KeyLanguage.user_mode_config: 'User mode configuration',
  KeyLanguage.logout: 'Logout',
  KeyLanguage.confirm: 'OK',
  KeyLanguage.cancel: 'Cancel',
  KeyLanguage.notification: 'Notification',
  KeyLanguage.not_received_otp: 'Did not receive OTP? ',
  KeyLanguage.resend_otp: 'Resend OTP',
  KeyLanguage.report: 'Report',
  KeyLanguage.today: 'Today',
  KeyLanguage.yesterday: 'Yesterday',
  KeyLanguage.this_week: 'This week',
  KeyLanguage.last_week: 'Last week',
  KeyLanguage.option: 'Option',
  KeyLanguage.option_high: 'Advanced settings',
  KeyLanguage.condition_use: 'Condition of use',
  KeyLanguage.most_use_app: 'Most used applications',
  KeyLanguage.most_used_users: 'Most used users',
  KeyLanguage.overview: 'Overview',
  KeyLanguage.birthday: 'Birthday',
  KeyLanguage.connect: 'Connect',
  KeyLanguage.full_name: 'Full name',
  KeyLanguage.statistical: 'statistical',
  KeyLanguage.access_manage: 'Access management',
  KeyLanguage.options: 'optional',
  KeyLanguage.cannot_blank: 'Do not leave this section blank',
  KeyLanguage.password_not_mach: 'Password does not match',
  KeyLanguage.lessSix: 'Field length is too short',
  KeyLanguage.notEmail: 'Email invalidate',
  KeyLanguage.package: 'Package:',
  KeyLanguage.service_usage_time: 'Service usage time:',
  KeyLanguage.activation_date: 'Activation date:',
  KeyLanguage.expiration_date: 'Expiration date:',
  KeyLanguage.extend_package: 'Extend package',
  KeyLanguage.select_the_package: 'Select the package',
  KeyLanguage.we_will_contact_you: 'We will contact you',
};
