
import 'package:base_pm2/data/model/profile/profile_model.dart';

class ProfileManager {
  ProfileManager._internal();

  static final ProfileManager _userManager = ProfileManager._internal();

  factory ProfileManager() => _userManager;

  ProfileModel? _profileModel;

  void setProfileModel(ProfileModel? model) => _profileModel = model;

  ProfileModel getProfile() => _profileModel ?? ProfileModel();
}
