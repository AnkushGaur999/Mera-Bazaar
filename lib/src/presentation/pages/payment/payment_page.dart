import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mera_bazaar/src/core/constants/app_colors.dart';
import 'package:mera_bazaar/src/domain/entities/payment/payment_entity.dart';
import 'package:mera_bazaar/src/presentation/bloc/payment/payment_bloc.dart';
import 'package:mera_bazaar/src/presentation/pages/payment/widgets/payment_method_card.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is ProcessPaymentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to order confirmation or success page
        } else if (state is ProcessPaymentFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Payment'),
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline),
                onPressed: () {
                  // Show payment help
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary Section
                  _buildSectionTitle('Order Summary'),
                  SizedBox(height: 12.h),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        children: [
                          _buildSummaryRow('Subtotal', '\$149.99'),
                          SizedBox(height: 12.h),
                          _buildSummaryRow('Delivery Charges', '\$10.00'),
                          SizedBox(height: 12.h),
                          _buildSummaryRow('Tax', '\$15.00'),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: const Divider(height: 1),
                          ),
                          _buildSummaryRow(
                            'Total Amount',
                            '\$174.99',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Payment Methods Section
                  _buildSectionTitle('Payment Method'),
                  SizedBox(height: 12.h),
                  PaymentMethodCard(
                    icon: Icons.credit_card,
                    title: 'Credit/Debit Card',
                    subtitle: 'Pay with Visa, MasterCard, or American Express',
                    onTap: () {
                      // Handle card payment
                    },
                  ),
                  SizedBox(height: 12.h),
                  PaymentMethodCard(
                    icon: Icons.account_balance,
                    title: 'Bank Transfer',
                    subtitle: 'Pay directly from your bank account',
                    onTap: () {
                      // Handle bank transfer
                    },
                  ),
                  SizedBox(height: 12.h),
                  PaymentMethodCard(
                    icon: Icons.payment,
                    title: 'UPI Payment',
                    subtitle: 'Pay using Google Pay, PhonePe, or Paytm',
                    onTap: () {
                      // Handle UPI payment
                    },
                  ),
                  SizedBox(height: 24.h),

                  // Secure Payment Section
                  _buildSectionTitle('Secure Payment'),
                  SizedBox(height: 12.h),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: Colors.green,
                            size: 24.r,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Your payment information is secure and encrypted',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Pay Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          state is ProcessPaymentLoading
                              ? null
                              : () {
                                final paymentEntity = PaymentEntity(
                                  amount: 174.99,
                                  paymentMethod: 'Credit Card',
                                  status: 'Pending',
                                  createdAt: DateTime.now(),
                                );
                                context.read<PaymentBloc>().add(
                                  ProcessPaymentEvent(
                                    paymentEntity: paymentEntity,
                                  ),
                                );
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 2,
                      ),
                      child:
                          state is ProcessPaymentLoading
                              ? SizedBox(
                                height: 24.h,
                                width: 24.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                'Pay Now',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Payment Security Info
                  Center(
                    child: Text(
                      'By clicking Pay Now, you agree to our Terms & Conditions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14.sp : 12.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black87 : Colors.grey[600],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 12.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.primaryColor : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
