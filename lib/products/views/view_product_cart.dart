import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/auth/model/user_model.dart';
import 'package:first_app/auth/view/login_screen.dart';
import 'package:first_app/util/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

import '../controller/product_controller.dart';
import '../models/product_model.dart';

class ProductCarts extends StatefulWidget {
  ProductCarts({Key? key, required this.userModel}) : super(key: key);
  UserModel userModel;

  @override
  State<ProductCarts> createState() => _ProductCartsState();
}

class _ProductCartsState extends State<ProductCarts> {
  List<ProductModel> listProducts = [];
  void getDataFromAPI() async {
    await ProductController().getProduct().then((value) {
      setState(() {
        listProducts = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://scontent.fpnh5-2.fna.fbcdn.net/v/t39.30808-6/325662877_708474324278729_5115514683264821608_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=8bfeb9&_nc_eui2=AeEEWxdKS2e9mDMXesknctb1kFHFWElzyFuQUcVYSXPIWz8sdc91fmAmM-cpUq1_LhkpuEti-JnJUvM5eWphiiSH&_nc_ohc=ODpwFE47qpIAX81ZKNW&tn=v-VIoGmE8telv0Uy&_nc_ht=scontent.fpnh5-2.fna&oh=00_AfD-sPR49lnFHsB6Yq0LBWnOefyscKQitRYiaqj2jkkwMQ&oe=63C7E993'))),
                child: Wrap(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                            height: 150,
                            width: 150,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://imgs.search.brave.com/Ir2pVlZagQ5XVd9QjZUG4-RVLjR9caMxZmusR9hTpZI/rs:fit:400:400:1/g:ce/aHR0cHM6Ly9kMmtm/OHB0bHhjaW5hOC5j/bG91ZGZyb250Lm5l/dC9ZSDVURkNFMVFZ/LXByZXZpZXcucG5n'),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.userModel.name.firstname} ${widget.userModel.name.lastname}',
                        style: styleL,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Text(
                        widget.userModel.email,
                        style: styleS,
                      ),
                    )
                  ],
                ),
              ),
              ExpansionTile(
                childrenPadding: const EdgeInsets.only(left: 40),
                leading: const CircleAvatar(
                  child: Icon(Icons.warehouse),
                ),
                title: const Text(
                  'Address',
                  style: styleM,
                ),
                children: [
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Location', style: styleM),
                    subtitle: Row(
                      children: [
                        Text(
                          widget.userModel.address.geolocation.lat,
                        ),
                        Text(
                          widget.userModel.address.geolocation.long.toString(),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.location_city),
                    title: const Text('City', style: styleM),
                    subtitle: Text(
                      widget.userModel.address.city.toString(),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.streetview_sharp),
                      title: const Text('Road', style: styleM),
                      subtitle:
                          Text(widget.userModel.address.street.toString())),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.home_work),
                      title: const Text('N˚', style: styleM),
                      subtitle:
                          Text(widget.userModel.address.number.toString())),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.pin_drop),
                      title: const Text('ZipCode', style: styleM),
                      subtitle:
                          Text(widget.userModel.address.zipcode.toString()))
                ],
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
                title: Text(
                  'sign Out'.toUpperCase(),
                ),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Do you want to Sign out this account',
                              style: styleSNormal,
                            ),
                            actions: [
                              MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: styleM,
                                  )),
                              MaterialButton(
                                color: Colors.red,
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text('ok', style: styleM),
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.logout)),
              ),
            ]),
          ),
        ),
        appBar: AppBar(
          title: Text('Product Cart'.toUpperCase()),
        ),
        body: ListView.builder(
          itemCount: listProducts.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(listProducts[index].title),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 120,
                            child: CachedNetworkImage(
                              imageUrl: listProducts[index].image,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReadMoreText(
                            listProducts[index].description,
                            trimLines: 6,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: ' Show more',
                            trimExpandedText: ' Show less',
                            lessStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            moreStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$ ${listProducts[index].price}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RatingBar.builder(
                          initialRating: listProducts[index].rating.rate,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          unratedColor: Colors.black,
                          itemCount: 5,
                          itemSize: 15.0,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              //  _rating = rating;
                            });
                          },
                          updateOnDrag: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text(listProducts[index].rating.count.toString()),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            listProducts[index].category.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.redAccent),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
