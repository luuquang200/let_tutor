import 'dart:developer';

class WalletInfo {
  final String? id;
  final String? userId;
  final String? amount;
  final bool? isBlocked;
  final String? createdAt;
  final String? updatedAt;
  final int? bonus;

  WalletInfo({
    this.id,
    this.userId,
    this.amount,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.bonus,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    try {
      return WalletInfo(
        id: json['id'] as String?,
        userId: json['userId'] as String?,
        amount: json['amount'] as String?,
        isBlocked: json['isBlocked'] as bool?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        bonus: json['bonus'] as int?,
      );
    } catch (e) {
      log('Error when parsing json to WalletInfo:');
      log('$e');
      throw Exception('Error when parsing json to WalletInfo');
    }
  }
}
