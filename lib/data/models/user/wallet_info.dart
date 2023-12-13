class WalletInfo {
  final String id;
  final String userId;
  final String amount;
  final bool isBlocked;
  final String createdAt;
  final String updatedAt;
  final int bonus;

  WalletInfo({
    required this.id,
    required this.userId,
    required this.amount,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
    required this.bonus,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    return WalletInfo(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount'],
      isBlocked: json['isBlocked'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      bonus: json['bonus'],
    );
  }
}
