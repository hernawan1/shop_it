import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_it/common/constant.dart';
import 'package:shop_it/sqlite/cart.dart';
import 'package:shop_it/src/cart/model/cart.dart';
import 'package:sizer/sizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int qty = 1;
  int harga = 1000;
  String button = 'nonfuction';
  late int newharga = 1000;

  int _total = 0;

  void _calcTotal() async {
    var total = await CartProvider.db.calculateTotal();
    print("total: ${total}");

    setState(() {
      if (total == null) {
        _total = 0;
      } else {
        _total = total;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calcTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: Center(
            child: Text(
              'Shopping Cart',
              style: TextStyle(fontSize: h4, fontWeight: semiBold),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  CartProvider.db.deleteCartAll();
                  _calcTotal();
                },
                icon: const Icon(Icons.delete_outline_outlined, size: 30))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.72,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        child: FutureBuilder<List<Item>>(
                            future: CartProvider.db.fetchCart(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return const Center(
                                  child: Text("Loading..."),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemExtent: 180,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                            flex: 5,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    right: 10),
                                                height: 150,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 0.8,
                                                      blurRadius: 2,
                                                      offset: Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Row(children: <Widget>[
                                                  Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        child: Container(
                                                            child: CachedNetworkImage(
                                                                imageUrl: snapshot
                                                                    .data[index]
                                                                    .image
                                                                    .toString(),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                fit: BoxFit
                                                                    .contain)),
                                                      )),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(12),
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .title
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "USD ${snapshot.data[index].price.toString()}",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              semiBold),
                                                                    )
                                                                  ]),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    child: Row(
                                                                        children: <Widget>[
                                                                          InkWell(
                                                                            child:
                                                                                Container(
                                                                              width: 30.0,
                                                                              height: 30.0,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: const BorderRadius.all(
                                                                                    Radius.circular(5.0),
                                                                                  ),
                                                                                  border: Border.all(color: grey),
                                                                                  color: white),
                                                                              child: const Center(
                                                                                child: Text('-', style: TextStyle(color: black, fontSize: 16.0)),
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentSum = snapshot.data[index].sum!;
                                                                              currentSum -= 1;
                                                                              setState(() {
                                                                                if (currentSum == 0) {
                                                                                  CartProvider.db.deleteCart(snapshot.data[index].id);
                                                                                  _calcTotal();
                                                                                } else {
                                                                                  CartProvider.db.updateCart(snapshot.data[index].id, currentSum);
                                                                                  _calcTotal();
                                                                                }
                                                                              });
                                                                              print(currentSum);
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                2.h,
                                                                          ),
                                                                          Text(
                                                                            snapshot.data[index].sum.toString(),
                                                                            style:
                                                                                TextStyle(fontWeight: semiBold),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                2.h,
                                                                          ),
                                                                          InkWell(
                                                                            child:
                                                                                Container(
                                                                              width: 30.0,
                                                                              height: 30.0,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: const BorderRadius.all(
                                                                                    Radius.circular(5.0),
                                                                                  ),
                                                                                  border: Border.all(color: grey),
                                                                                  color: white),
                                                                              child: Center(
                                                                                child: Text('+', style: TextStyle(color: black, fontSize: 16.0)),
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentSum = snapshot.data[index].sum!;
                                                                              currentSum += 1;
                                                                              setState(() {
                                                                                CartProvider.db.updateCart(snapshot.data[index].id, currentSum);
                                                                                _calcTotal();
                                                                              });
                                                                              print(currentSum);
                                                                            },
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          CartProvider
                                                                              .db
                                                                              .deleteCart(snapshot.data[index].id);
                                                                          _calcTotal();
                                                                        });
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .delete_outline_outlined,
                                                                          size:
                                                                              30))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ]),
                                              ),
                                            )),
                                      ],
                                    );
                                  },
                                );
                              }
                            })))),
            FutureBuilder(
                future: CartProvider.db.getalldata(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  var data = snapshot.data;
                  print('Muncul: ${data}');
                  if (snapshot.data == null) {
                    return Center(
                        child: Container(
                      child: new Text("Loading..."),
                    ));
                  } else {
                    return _total == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.all(35),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF5EAAA8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Center(
                                        child: Text(
                                      "There are currently no orders",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )))
                              ])
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0.8,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Column(children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text(
                                          "Total :",
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'USD ${_total != 0 ? _total : '0'}',
                                          style: const TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Center(
                                            child: Text(
                                          "Proceed to checkout",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      onTap: () async {},
                                    )
                                  ]),
                                )),
                          );
                  }
                })
          ]),
        ));
  }
}
