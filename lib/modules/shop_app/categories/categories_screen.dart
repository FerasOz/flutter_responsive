import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/shop_app/cubit/states.dart';
import 'package:new_project_flutter/models/shop_app/categories/categories_model.dart';
import 'package:new_project_flutter/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItems(ShopCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => divider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length
        );
      },
    );
  }

  Widget buildCatItems(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
              image: NetworkImage('${model.image}'),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
              '${model.name}',
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
          ),
          Spacer(),
          const Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }

}
