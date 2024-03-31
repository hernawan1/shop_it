import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/common/constant.dart';
import 'package:shop_it/sqlite/cart.dart';
import 'package:shop_it/src/cart/screen/cart.dart';
import 'package:shop_it/src/produk/bloc/search_produk_bloc.dart';
import 'package:shop_it/src/produk/screen/detail_produk.dart';
import 'package:sizer/sizer.dart';

class SearchProduk extends StatefulWidget {
  const SearchProduk({super.key});

  @override
  State<SearchProduk> createState() => _SearchProdukState();
}

class _SearchProdukState extends State<SearchProduk> {
  final SearchProdukBloc _searchProdukBloc = SearchProdukBloc();
  TextEditingController searchController = TextEditingController();
  int notif = 0;

  void clearValue() {
    searchController.clear();
    setState(() {
      _searchProdukBloc.add(SearchProdukName("none"));
    });
  }

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
        appBar: AppBar(
          title: Center(
            child: Text(
              'Search',
              style: TextStyle(fontSize: h4, fontWeight: semiBold),
            ),
          ),
          backgroundColor: white,
          actions: [
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
          ],
        ),
        body: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 1000.h,
                maxHeight: 5000.h,
                maxWidth: 100.w,
                minWidth: 100.w),
            child: Stack(children: [
              BlocProvider(
                create: (context) => _searchProdukBloc,
                child: BlocListener<SearchProdukBloc, SearchProdukState>(
                    listener: (context, state) {
                  if (state is SearchProdukLoaded) {
                    print(state);
                  }
                }, child: BlocBuilder<SearchProdukBloc, SearchProdukState>(
                  builder: (context, state) {
                    if (state is SearchProdukInitial) {
                      return Container();
                    } else if (state is SearchProdukLoaded) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: 500.h,
                            maxHeight: 1000.h,
                            maxWidth: 100.w,
                            minWidth: 100.w),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 10.h,
                              ),
                              ListView.builder(
                                  cacheExtent: 100,
                                  controller:
                                      ScrollController(keepScrollOffset: false),
                                  itemExtent: 180,
                                  shrinkWrap: true,
                                  itemCount:
                                      state.produkModel.produkList!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    DetailProduk(
                                                        produk: state
                                                                .produkModel
                                                                .produkList![
                                                            index]))).then(
                                            (value) => setNotif());
                                      },
                                      child: Row(
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: Container(
                                                              child: CachedNetworkImage(
                                                                  imageUrl: state
                                                                      .produkModel
                                                                      .produkList![
                                                                          index]
                                                                      .images![
                                                                          0]
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
                                                              EdgeInsets.all(
                                                                  12),
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
                                                                          state
                                                                              .produkModel
                                                                              .produkList![index]
                                                                              .title
                                                                              .toString(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "USD ${state.produkModel.produkList![index].price.toString()}",
                                                                          style:
                                                                              TextStyle(fontWeight: semiBold),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                1.h),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.star,
                                                                              color: Colors.yellow,
                                                                              size: 15,
                                                                            ),
                                                                            const Text(
                                                                              '3.5',
                                                                              style: TextStyle(fontSize: 10),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 2.w,
                                                                            ),
                                                                            const Text(
                                                                              '259 Views',
                                                                              style: TextStyle(fontSize: 10),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ]),
                                                                ]),
                                                          ),
                                                        )),
                                                  ]),
                                                ),
                                              )),
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                )),
              ),
              Container(
                height: 10.h,
                decoration: BoxDecoration(color: white),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        _searchProdukBloc.add(SearchProdukName(value));
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                clearValue();
                              },
                              icon: Icon(Icons.close)),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2, color: primary),
                          ),
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: primary)),
                          hintText: 'Masukan Nama',
                          labelStyle: const TextStyle(color: grey),
                          floatingLabelStyle: const TextStyle(color: primary),
                          fillColor: primary,
                          focusColor: primary),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
