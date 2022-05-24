import 'package:flutter/material.dart';

class RegisterCheck with ChangeNotifier {
  // ignore: prefer_final_fields
  int _combinationUserIdCheck = 0;
  int _duplicateUserIdCheck = 0;

  String _currentUserId = '';

  bool _passwordLengthCheck = false;
  bool _passwordCombinationCheck = true;
  bool _passwordSameNumberCheck = true;

  int _confirmPasswordCheck = 0;

  String _currentPassword = '';

  int get combinationUserIdCheck => _combinationUserIdCheck;
  int get duplicateUserIdCheck => _duplicateUserIdCheck;
  String get currentUserId => _currentUserId;

  bool get passwordLengthCheck => _passwordLengthCheck;
  bool get passwordCombinationCheck => _passwordCombinationCheck;
  bool get passwordSameNumberCheck => _passwordSameNumberCheck;
  int get confirmPasswordCheck => _confirmPasswordCheck;
  String get currentPassword => _currentPassword;

  void setCurrentUserId(value) {
    _currentUserId = value;
    notifyListeners();
  }

  void setCurrentPassword(value) {
    _currentPassword = value;
    notifyListeners();
  }

  void changeDuplicateUserIdCheck(value) {
    _duplicateUserIdCheck = value;
    notifyListeners();
  }

  void changeCombinationUserIdCheck(value) {
    _combinationUserIdCheck = value;
    notifyListeners();
  }

  void changePasswordLengthCheck(state) {
    _passwordLengthCheck = state;
  }

  void changePasswordCombinationCheck(state) {
    _passwordCombinationCheck = state;
  }

  void changePasswordSameNumberCheck(state) {
    _passwordSameNumberCheck = state;
  }

  void changeConfirmPasswordCheck(value) {
    _confirmPasswordCheck = value;
  }
}

class ConsentToUseCheck with ChangeNotifier {
  bool _requiredTermsOfServiceState = false;
  bool _requiredPrivacyConsent = false;
  bool _selectPrivacyConsent = false;
  bool _selectBenefitInformationConsent = false;
  bool _requiredAgeLimit = false;

  bool get requiredTermsOfServiceState => _requiredTermsOfServiceState;
  bool get requiredPrivacyConsent => _requiredPrivacyConsent;
  bool get selectPrivacyConsent => _selectPrivacyConsent;
  bool get selectBenefitInformationConsent => _selectBenefitInformationConsent;
  bool get requiredAgeLimit => _requiredAgeLimit;

  void changeRequiredTermsOfServiceState() {
    _requiredTermsOfServiceState = !_requiredTermsOfServiceState;
    notifyListeners();
  }

  void changeRequiredPrivacyConsent() {
    _requiredPrivacyConsent = !_requiredPrivacyConsent;
    notifyListeners();
  }

  void changeSelectPrivacyConsent() {
    _selectPrivacyConsent = !_selectPrivacyConsent;
    notifyListeners();
  }

  void changeSelectBenefitInformationConsent() {
    _selectBenefitInformationConsent = !_selectBenefitInformationConsent;
    notifyListeners();
  }

  void changeSequiredAgeLimit() {
    _requiredAgeLimit = !_requiredAgeLimit;
    notifyListeners();
  }

  void acceptFullConsent() {
    _requiredTermsOfServiceState = true;
    _requiredPrivacyConsent = true;
    _selectPrivacyConsent = true;
    _selectBenefitInformationConsent = true;
    _requiredAgeLimit = true;
  }

  void rejectionFullConsent() {
    _requiredTermsOfServiceState = false;
    _requiredPrivacyConsent = false;
    _selectPrivacyConsent = false;
    _selectBenefitInformationConsent = false;
    _requiredAgeLimit = false;
  }
}
