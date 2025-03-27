import 'package:flutter/material.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/account/account_screen.dart';
import 'package:mera_bazaar/src/presentation/pages/dashboard/home/widgets/item_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;

  void _animate() {
    setState(() {
      _width = _width == 100 ? 200 : 100;
      _height = _height == 100 ? 200 : 100;
      _color = _color == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  void _scrollToTop(BuildContext context, int page) {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        //  ScaffoldMessenger.of(context)
        //      .showSnackBar(SnackBar(content: Text("Page $page")));

        setState(() {
          isLoading = true;
        });

        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          isLoading = false;
        });

        // increase page size
        // call api to fetch more data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _scrollToTop(context, 1);
    return Scaffold(
        body: SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 46,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black45, width: 1)),
                child: InkWell(
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Search")
                    ],
                  ),
                  onTap: () {},
                ),
              ))
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 6,
            margin: const EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  return const ItemCategory();
                }),
          ),
          InkWell(
            onTap: _animate,
            child: AnimatedContainer(
              width: _width,
              height: _height,
              duration: (const Duration(seconds: 1)),
              child: Center(child: Text("Animation")),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountScreen()));
            },
            child: Hero(
                tag: "hero-tag",
                child: Container(
                  height: 280,
                  width: 280,
                  color: Colors.green,
                )),
          ),
          ListView.builder(
              itemCount: 20 + (isLoading ? 1 : 0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == 20) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Card(
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("List Item"),
                    ));
              }),
        ],
      ),
    ));
  }
}
