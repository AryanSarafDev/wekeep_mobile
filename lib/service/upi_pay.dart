import 'package:flutter/material.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';

class UpiPayment {
  UpiIndia _upiIndia = UpiIndia();

  Future<UpiResponse> initiateTransaction(UpiApp app,String upiid,double amount) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: upiid,
      receiverName: 'Merchant',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: amount,
    );
  }
}
