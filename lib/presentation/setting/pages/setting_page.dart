
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/components/spaces.dart';
import 'package:pos/core/constants/colors.dart';
import 'package:pos/data/datasource/auth_local_datasource.dart';
import 'package:pos/data/datasource/product_local_datasource.dart';
import 'package:pos/presentation/auth/pages/login_page.dart';
import 'package:pos/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:pos/presentation/home/bloc/product/product_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          
          // ElevatedButton(
          //   onPressed: () => context.push(const ManageProductPage()),
          //   child: const Text('Manage Product'),
          // ),
          // const SpaceWidth(15.0),

          ElevatedButton(
            onPressed: () {}, //=> context.push(const ManagePrinterPage()),
            child: const Text('Manage Printer'),
          ),
          const SpaceWidth(15.0),
          const Divider(),

          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: (){},
                success: (_) async{
                  await ProductLocalDatasource.instance.removeAllProduct();
                  await ProductLocalDatasource.instance
                      .insertProduct(_.products.toList());

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.primary,
                      content: Text('Sync Data Success'))
                  );
                }
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: (){
                  return ElevatedButton(
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(const ProductEvent.fetch());
                    },
                    child: const Text("Sync Data"));
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );              
            },
          ),
          const Divider(),

          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) {
                  AuthLocalDatasource().removeAuthData();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                      )
                  );
                },
              );
            },
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: const Text('Logout'));
            },
          ),
          const Divider(),

        ],
      ),
    );
  }
}
