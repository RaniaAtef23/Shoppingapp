import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/service_locator.dart';
import 'package:shopping_app/features/Home/data/models/Category.dart';
import 'package:shopping_app/features/Home/data/repo/repo_imp.dart';
import 'package:shopping_app/features/Home/presentation/Manager/Fetch_Product/fetch_product_cubit.dart';
import 'package:shopping_app/features/Home/presentation/Manager/Fetch_Product/fetch_product_state.dart';
import 'package:shopping_app/features/Categories/views/CategoryScreen.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/ImageSlider.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/ProductGridView.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/popular_product_list.dart';
import 'package:shopping_app/features/authentication/create_account_view.dart';
import 'package:shopping_app/features/authentication/login_view.dart';
import '../../data/models/Category.dart';
import '../../data/models/Category.dart';
import '../../data/models/Category.dart';
import 'widgets/HorizontalCategoryList.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  final List<String> images = [
    'assets/3245285.jpg',
    'assets/3282665.jpg',
    'assets/5028786.jpg',
    'assets/sl_100222_53080_35.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchProductCubit(getIt.get<RepoHomeImpl>())..fetchProducts(),
      child: BlocBuilder<FetchProductCubit, FetchProductState>(
        builder: (context, state) {
          if (state is FetchProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchProductSuccess) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(Icons.menu, color: Colors.orange),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    );
                  },
                ),
                title: Text(
                  "Home",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    color: Colors.orange,
                    onPressed: () {
                      // Add functionality for notifications button
                    },
                  ),
                ],
              ),
              drawer: Drawer(
                child: Column(
                  children: [
                    const UserAccountsDrawerHeader(
                      accountName: Text('User Name'),
                      accountEmail: Text('user@example.com'),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage('assets/a2020cf5-9244-4244-8b8b-46186a571545.jpg'),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home, color: Colors.orange),
                      title: const Text('Home'),
                      onTap: () {
                        Navigator.pop(context); // Close drawer
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.category, color: Colors.orange),
                      title: const Text('Categories'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const CategoryScreen()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.orange),
                      title: const Text('Sign Up'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Create_account()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.login_rounded, color: Colors.orange),
                      title: const Text('Login'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Login_view()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ImageSlider(images: images),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: HorizontalCategoryList(
                        categories: categories, // Ensure this is fetched in the state
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Popular Products',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PopularProductList(products: state.popularProducts),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Flash Sale',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PopularProductList(products: state.flashSaleProducts),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'You might like',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProductGridView(products: state.moreproducts),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Error fetching data"));
          }
        },
      ),
    );
  }
}
