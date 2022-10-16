// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String name;
  String address;
  double balance;
  double spent;
  User({
    required this.name,
    required this.address,
    required this.balance,
    required this.spent,
  });

  void reduceBalance(double price) {
    balance -= price;
    spent += price;
  }

  @override
  String toString() {
    return 'User(name: $name, address: $address, balance: $balance,' +
        "spent: $spent)";
  }
}
