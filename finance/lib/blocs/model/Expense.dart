final String expenses = 'expenses';

class ExpenseFields {
  static final List<String> values = [
    /// Add all fields
    id, userId, title, cost, date
  ];

  static final String id = '_id';
  static final String userId = 'userId';
  static final String title = 'title ';
  static final String cost = 'cost';
  static final String date= 'date';
}


class Expense {
  final int? id;
  final String userId;
  final String title;
  final String cost;
  final String description = '';
  final String date;

  const Expense({
    this.id,
    required this.userId,
    required this.title,
    required this.cost,
    required this.date
  });

  Expense copy({
    int? id,
    String? userId,
    String? title,
    String? cost,
    String? date,
  }) =>
      Expense(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        cost: cost ?? this.cost,
        date: date ?? this.date,
      );


    Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'cost': cost,
      'date': date
    };
    }

  @override
  String toString() {
    return 'Expense{userId: $userId, title: $title, cost:$cost, date:$date}';
  }
}