class Product{
  int? id;
  String? name;
  int? quantity;
  double? price;
  double? total;
  bool? status;

  Product({this.id, this.name, this.quantity, this.price, this.total, this.status});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id':id,
      'name':name,
      'quantity':quantity,
      'price':price,
      'total':total,
      'status':status! ? 1 : 0
    };
    return map;
  }
}