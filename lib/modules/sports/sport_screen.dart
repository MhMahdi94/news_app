// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return cubit.sportNews.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildNewsItem(cubit.sportNews[index], context);
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black26,
                    ),
                  );
                },
                itemCount: cubit.sportNews.length);
      },
      listener: (context, state) {},
    );
  }
}
