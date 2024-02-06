class THSYDUser {
  const THSYDUser({
    required this.username,
    this.coin = 0,
  });

  final String username;
  final int coin;

  THSYDUser copyWith({
    String? username,
    int? coin,
  }) {
    return THSYDUser(
      username: username ?? this.username,
      coin: coin ?? this.coin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'coin': coin,
    };
  }

  factory THSYDUser.fromMap(Map<String, dynamic> map) {
    return THSYDUser(
      username: map['username'] as String,
      coin: map['coin'] as int,
    );
  }
}
