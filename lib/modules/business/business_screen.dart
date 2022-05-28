// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return state is AppGetBusinessNewsLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildNewsItem(cubit.businessNews[index], context);
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
                itemCount: cubit.businessNews.length);
      },
      listener: (context, state) {},
    );
  }
}
