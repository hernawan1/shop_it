import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_it/common/constant.dart';
import 'package:shop_it/sqlite/cart.dart';
import 'package:shop_it/src/cart/model/cart.dart';
import 'package:shop_it/src/cart/screen/cart.dart';
import 'package:shop_it/src/produk/model/produklist.dart';
import 'package:sizer/sizer.dart';

class DetailProduk extends StatefulWidget {
  const DetailProduk({super.key, required this.produk});
  final ProdukList produk;
  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  int notif = 0;
  void setNotif() async {
    notif = await CartProvider.db.countCart();
    setState(() {
      notif = notif;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: white, actions: [
        Badge(
          textStyle: TextStyle(fontSize: 12),
          textColor: Colors.white,
          label: Text(notif.toString()),
          child: IconButton(
            onPressed: () {
              Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => CartView()))
                  .then((value) => setNotif());
            },
            icon: const Icon(
              Icons.shopping_basket_outlined,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          width: 4.w,
        )
      ]),
      body: Container(
        height: 1000,
        width: 1000,
        decoration: BoxDecoration(color: white),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CachedNetworkImage(
                imageUrl: widget.produk.images![0].toString(),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "USD ${widget.produk.price}",
                    style: TextStyle(
                        color: primary,
                        fontSize: subtitle,
                        fontWeight: semiBold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                widget.produk.title.toString(),
                style: TextStyle(fontSize: h2, fontWeight: bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 18,
                  ),
                  const Text(
                    '3.5',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  const Text(
                    '259 Views',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                widget.produk.description.toString(),
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: text, fontWeight: bold),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
              child: InkWell(
                onTap: () async {
                  final cart = Item(
                      id: widget.produk.id,
                      title: widget.produk.title,
                      image: widget.produk.images![0].toString(),
                      price: widget.produk.price,
                      sum: 1);
                  await CartProvider.db.addItem(cart);
                  Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => CartView()))
                      .then((value) => setNotif());
                },
                child: Container(
                  width: 100.w,
                  padding: const EdgeInsets.symmetric(
                    vertical: marginVertical * 1,
                  ),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(
                      marginVertical / 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Add to Cart",
                      style: textStyle.copyWith(
                        color: white,
                        fontWeight: semiBold,
                        fontSize: h4,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
