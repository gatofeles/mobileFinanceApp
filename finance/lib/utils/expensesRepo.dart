import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/blocs/model/expense.dart';
import 'package:finance/blocs/model/Expenses.dart';

class FirestoreDatabase {
  // Atributo que irá afunilar todas as consultas
  static FirestoreDatabase helper = FirestoreDatabase._createInstance();
  // Construtor privado
  FirestoreDatabase._createInstance();

  // uid do usuário logado
  String? uid;

  // Ponto de acesso com o servidor
  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection("expenses");

  Future<Expense> getNote(noteId) async {
    DocumentSnapshot doc =
        await expenseCollection.doc(uid).collection("my_expenses").doc(noteId).get();
    Expense note = Expense.fromMap(doc.data());
    return note;
  }

  Future<bool> insertExepense(Expense expense) async {

    try {
      DocumentReference ref = await expenseCollection
        .doc(uid)
        .collection("my_expenses")
        .add({
      "title": expense.title,
      "cost": expense.cost,
      "date": expense.date
    });
     return true;
      
    } catch (e) {
      return false;
    }
    
  }

  Future<bool> deleteExpense(expenseId) async {
    try {
      await expenseCollection.doc(uid).collection("my_expenses").doc(expenseId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  ExpenseCollection _expenseListFromSnapshot(QuerySnapshot snapshot) {
    ExpenseCollection expenseCollection = ExpenseCollection();
    for (var doc in snapshot.docs) {
      Expense expense = Expense.fromMap(doc.data());
      expenseCollection.insertExpenseOfId(doc.id, expense);
    }
    return expenseCollection;
  }

  Future<ExpenseCollection> getExpenseList() async {
    QuerySnapshot snapshot =
        await expenseCollection.doc(uid).collection("my_expenses").get();

    return _expenseListFromSnapshot(snapshot);
  }

  Stream get stream {
    return expenseCollection
        .doc(uid)
        .collection("my_expenses")
        .snapshots()
        .map(_expenseListFromSnapshot);
  }
}