import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Card{
 

  Card(this.title, this.cost, this.description, this.date, this._id);
    String _id; 
    String title;
    String cost;
    String description;
    String date;

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(json['title'] as String,  json['cost'].toString(),  json['description'] as String, json['date'] as String, json['_id'] as String);
  }

}

class Creds{
  final String email;
  final String password;
  
  Creds(this.email, this.password);

  Map<String, dynamic> toJson() => {
            "email": email,
            "password":password
          };
}

class User{
  final String userId;
  final String token;

  User(this.userId, this.token);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['userId'], json['token']);
  }

}

class HttpHelper{

  var backEnd = "https://financeappback.herokuapp.com/";

  var client = http.Client();
   Map<String, String> requestHeaders = {
       'x-auth-token': ''
     };
  
  
  Future<List<Card>> GetAllExpesenses(String userId, String token) async {
    requestHeaders['x-auth-token'] = token;

    final response = await client.get(
      Uri.parse(backEnd+"transactions/trans/${userId}"),
      headers: requestHeaders
    );

    Map expenses = jsonDecode(response.body);
    List<Card> cards = [];

    expenses.forEach((key, value) {
      value.forEach((card){
        cards.add(Card.fromJson(card));

      });
     });

    return cards;

  }

  Future<User> GetCreds(String email, String password) async{
    
    var creds = Creds(email, password);

    final response = await client.post(
      Uri.parse(backEnd+"users/login"),
      headers: requestHeaders,
      body: creds.toJson()
    );

    return User.fromJson(jsonDecode(response.body));
  }


}