import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/screens/categorised_offered_products.dart';
import 'package:m_soko/home/products/widgets/products_advertisement.dart';
import 'package:m_soko/navigation/page_transitions.dart';

class SelectedCategoryPage extends StatelessWidget {
  final String title;

  SelectedCategoryPage({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.bgColour,
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _topBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: advertisement_block(),
                    ),
                    _mainBody(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('Sort by'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('Filters'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _mainBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: futureCheckSelectedCategoryProducts(title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> products = snapshot.data!;
            return Container(
              // color: Colors.red,
              height: products.length / 2 * 300,
              child: GridView.builder(
                primary: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductThumbnail(
                    // prdCategoryImage: (products[index]['prdItemName']),
                    prdCategory: (products[index]['prdItemPrice']).toString(),
                  );
                },
              ),
            );
          }
        });
  }
}

class ProductThumbnail extends StatelessWidget {
  final String prdCategoryImage;
  final String prdCategory;
  final int discountPercentage;

  ProductThumbnail({
    this.prdCategoryImage = 'assets/tests/T-shirts.png',
    required this.prdCategory,
    this.discountPercentage = 70,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ProductItemDetailPage(
              title: prdCategory,
              discountInPercentage: discountPercentage,
            );
          },
          transitionsBuilder: customTransition(const Offset(0, 0)),
        ));
      },
      child: Container(
        width: 180,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF51C5F6), Color.fromRGBO(8, 13, 148, 1)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 163,
                height: 145,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: AssetImage(prdCategoryImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prdCategory,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Upto $discountPercentage% off',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductItemDetailPage extends StatefulWidget {
  final String title;
  final int discountInPercentage;

  const ProductItemDetailPage({
    super.key,
    required this.title,
    required this.discountInPercentage,
  });

  @override
  State<ProductItemDetailPage> createState() => ProductItemDetailPageState();
}

class ProductItemDetailPageState extends State<ProductItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              '${widget.title} at upto ${widget.discountInPercentage}% off '),
        ),
        body: Container(

            // logic = filter out the items which have
            // prdDiscount = ${widget.discountInPercentage}
            // and prdCategory = ${widget.title}

            ),
      ),
    );
  }
}
