class Expense {
  Expense (this.title, this.cost, this.date);
  String title = "";
  String cost = "";
  String date = "";

  toMap() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["cost"] = cost;
    map["date"] = date;
    return map;
  }

  Expense.withData({title = "", cost= "", date = ""}) {
    title = title;
    cost = cost;
    date = date;
  }

   Expense.fromMap(map) {
    title = map["title"];
    cost = map["cost"];
    date = map["date"];
  }

  

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        json['title'] as String,
        json['cost'].toString(),
        json['date'] as String);
  }

  Map<String, dynamic> toJson() => { "title": title, "cost": cost, "date":date};
}