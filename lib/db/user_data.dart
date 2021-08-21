import 'dart:core';

class userData {
  String _name;
  String _accountNumber;
  String _phone;
  double _accountBalance;
  userData(this._name, this._accountNumber, this._accountBalance,
      [this._phone = '1234567890']);

  String get Name => _name;
  String get AccountNumber => _accountNumber;
  double get AccountBalance => _accountBalance;
  String get Phone => _phone;

  set Name(String newName) {
    this._name = newName;
  }

  set AccountNumber(String newAccountNumber) {
    this._accountNumber = newAccountNumber;
  }

  set AccountBalance(double newAccountBalance) {
    this._accountBalance = newAccountBalance;
  }

  set Phone(String newPhone) {
    this._phone = newPhone;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    map['Name'] =_name;
    map['AccountNumber'] = _accountNumber;
    map['AccountBalance'] = _accountBalance;
    map['Phone'] = _phone;
    return map;
  }

  userData.fromMapObject(Map<String, dynamic> map) {
    this.Name = map['Name'];
    this.AccountNumber = map['AccountNumber'];
    this.AccountBalance = map['AccountBalance'];
    this.Phone = map['Phone'];
  }
}
