import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class CustomAuthController extends GetxController {
  final LocalAuthentication _localAuth = LocalAuthentication();
  var isAuthenticated = false.obs;
  var errorMessage = ''.obs;
  Future<void> authenticate() async {
    try {
      bool isAuthSuccessful = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed.',
        options: AuthenticationOptions(
          useErrorDialogs: true,
            stickyAuth: false,
            sensitiveTransaction: true),
      );
      isAuthenticated.value = isAuthSuccessful;
      if (!isAuthenticated.value) {
        errorMessage.value = 'Please try again.';
      }
    } catch (e) {
      errorMessage.value = 'Authentication failed: Try after 30 Sec.';
    }
  }

  // Method to check biometric availability
  Future<void> checkBiometricAvailability() async {
    try {
      bool canCheck = await _localAuth.canCheckBiometrics;
      if (!canCheck) {
        errorMessage.value = 'Biometric authentication is not available.';
      }
    } catch (e) {
      errorMessage.value = 'Error checking biometric availability: $e';
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkBiometricAvailability();
  }
}