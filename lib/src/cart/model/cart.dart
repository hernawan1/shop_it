class Item {
  int? id;
  String? title;
  String? image;
  int? price;
  int? sum;

  Item({
    this.id,
    this.title,
    this.image,
    this.price,
    this.sum,
  });

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image':image,
      'price': price,
      'sum': sum,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Item{id:$id,title:$title,price:$price,sum:$sum}';
  }
}
