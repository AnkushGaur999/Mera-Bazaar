import 'package:mera_bazaar/src/data/models/payment/payment_response.dart';

/// Interface for payment data source operations.
///
/// This abstract class defines the contract for making payment-related
/// API calls. It includes methods for:
/// - Processing payments
abstract class PaymentDataSource {
  /// Processes a payment.
  ///
  /// This method should make an API call to process the given payment.
  /// It returns a success message string.
  ///
  /// [paymentData] - The payment data to process
  Future<String> processPayment({required PaymentResponse paymentData});
}
