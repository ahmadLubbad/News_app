import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage('${article['urlToImage']}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(

    width: double.infinity,

    height: 1,

    color: Colors.grey[300],

  ),
);

Widget articleBuilder(list) =>  ConditionalBuilder(
  condition: list.length>0,
  builder:  (context)=> ListView.separated
    (
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(list[index]),
    separatorBuilder: (context,index)=>myDivider(),
    itemCount: 10,
  ),
  fallback: (context)=>Center(child: CircularProgressIndicator(),),
);