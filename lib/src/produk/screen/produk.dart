import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/common/constant.dart';
import 'package:shop_it/sqlite/cart.dart';
import 'package:shop_it/src/cart/screen/cart.dart';
import 'package:shop_it/src/produk/bloc/kategori_produk_bloc.dart';
import 'package:shop_it/src/produk/bloc/produk_list_bloc.dart';
import 'package:shop_it/src/produk/model/kategori_produk.dart';
import 'package:shop_it/src/produk/model/produklist.dart';
import 'package:shop_it/src/produk/screen/detail_produk.dart';
import 'package:sizer/sizer.dart';

class Produk extends StatefulWidget {
  const Produk({super.key});

  @override
  State<Produk> createState() => _ProdukState();
}

class _ProdukState extends State<Produk> with TickerProviderStateMixin {
  final KategoriProdukBloc _artikelBloc = KategoriProdukBloc();
  final ProdukListBloc _produkListBloc = ProdukListBloc();
  late TabController _tabController;
  var idProduk;

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
    _produkListBloc.add(GetProduk());
    _artikelBloc.add(KategoriProdukList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 100.w, minWidth: 100.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Hi, Jhon',
                  style: TextStyle(fontSize: h3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'What are you looking for today ?',
                  style: TextStyle(fontSize: h1, fontWeight: semiBold),
                ),
              ),
              BlocProvider(
                create: (context) => _artikelBloc,
                child: BlocListener<KategoriProdukBloc, KategoriProdukState>(
                  listener: (context, state) {
                    if (state is KategoriProdukLoading) {
                      print(state);
                    }
                  },
                  child: BlocBuilder<KategoriProdukBloc, KategoriProdukState>(
                      builder: (context, state) {
                    if (state is KategoriProdukLoading) {
                      return Container();
                    } else if (state is KategoriProdukLoaded) {
                      final List<Tab> tabs = <Tab>[];
                      for (int i = 0;
                          i < state.kategoriProdukModel.dataKategori!.length;
                          i++) {
                        tabs.add(
                          Tab(
                            child: Container(
                              padding: EdgeInsets.only(left: 20.0, right: 20),
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: primary, width: 2)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(state
                                    .kategoriProdukModel.dataKategori![i].name
                                    .toString()),
                              ),
                            ),
                          ),
                        );
                      }
                      idProduk = state.kategoriProdukModel.dataKategori![1].id;
                      _tabController =
                          TabController(vsync: this, length: tabs.length);
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: TabBar(
                                isScrollable: true,
                                unselectedLabelColor: primary,
                                labelColor: Colors.white,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorPadding: EdgeInsets.zero,
                                indicatorColor: Colors.transparent,
                                dividerColor: Colors.transparent,
                                indicator: const BubbleTabIndicator(
                                  indicatorHeight: 35.0,
                                  indicatorColor: primary,
                                  tabBarIndicatorSize:
                                      TabBarIndicatorSize.label,
                                  indicatorRadius: 100,
                                ),
                                tabs: tabs,
                                controller: _tabController,
                                onTap: (value) {
                                  idProduk = state.kategoriProdukModel
                                      .dataKategori![value].id;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: 500.h,
                                    maxHeight: 5000.h,
                                    maxWidth: 100.w,
                                    minWidth: 100.w),
                                child: TabBarView(
                                    controller: _tabController,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: state
                                        .kategoriProdukModel.dataKategori!
                                        .map((KategoriProduk kategoriProduk) {
                                      idProduk = kategoriProduk.id;
                                      return BlocProvider(
                                        create: (context) => _produkListBloc,
                                        child: BlocListener<ProdukListBloc,
                                            ProdukListState>(
                                          listener: (context, state) {
                                            if (state is ProdukListErorr) {
                                              print(state);
                                            }
                                          },
                                          child: BlocBuilder<ProdukListBloc,
                                              ProdukListState>(
                                            builder: (context, state) {
                                              if (state is ProdukListInitial) {
                                                print(state);
                                              } else if (state
                                                  is ProdukListLoaded) {
                                                List<ProdukList> _produk = [];
                                                idProduk = kategoriProduk.id;
                                                for (int i = 0;
                                                    i <
                                                        state.produkModel
                                                            .produkList!.length;
                                                    i++) {
                                                  if (idProduk ==
                                                      state
                                                          .produkModel
                                                          .produkList![i]
                                                          .category!
                                                          .id) {
                                                    _produk.add(ProdukList(
                                                      id: state.produkModel
                                                          .produkList![i].id,
                                                      title: state.produkModel
                                                          .produkList![i].title,
                                                      price: state.produkModel
                                                          .produkList![i].price,
                                                      description: state
                                                          .produkModel
                                                          .produkList![i]
                                                          .description,
                                                      images: state
                                                          .produkModel
                                                          .produkList![i]
                                                          .images,
                                                      category: state
                                                          .produkModel
                                                          .produkList![i]
                                                          .category,
                                                    ));
                                                  }
                                                }
                                                return ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        minHeight: 500.h,
                                                        maxHeight: 5000.h,
                                                        maxWidth: 100.w,
                                                        minWidth: 100.w),
                                                    child: GridView.builder(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio:
                                                              0.76,
                                                          crossAxisSpacing: 0.6,
                                                        ),
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            _produk.length,
                                                        cacheExtent: 100,
                                                        controller:
                                                            ScrollController(
                                                                keepScrollOffset:
                                                                    false),
                                                        itemBuilder: (context,
                                                                index) =>
                                                            InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      CupertinoPageRoute(
                                                                          builder: (context) =>
                                                                              DetailProduk(produk: _produk[index]))).then(
                                                                      (value) =>
                                                                          setNotif());
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  width: 100,
                                                                  height: 50,
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.2),
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              2,
                                                                          offset: Offset(
                                                                              0,
                                                                              1),
                                                                        )
                                                                      ],
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              20))),
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          CachedNetworkImage(
                                                                              imageUrl: _produk[index].images![0].toString(),
                                                                              width: MediaQuery.of(context).size.width * 0.3,
                                                                              height: MediaQuery.of(context).size.height * 0.1,
                                                                              fit: BoxFit.cover),
                                                                          SizedBox(
                                                                            height:
                                                                                2.h,
                                                                          ),
                                                                          Text(
                                                                            _produk[index].title.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(fontSize: 13, fontWeight: semiBold),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                1.h,
                                                                          ),
                                                                          Text(
                                                                              'USD ${_produk[index].price.toString()}'),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
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
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ))));
                                              }
                                              return Container();
                                            },
                                          ),
                                        ),
                                      );
                                    }).toList()))
                          ]);
                    }
                    return Container();
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
