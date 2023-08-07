import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/social_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/social_app/cubit/states.dart';
import 'package:new_project_flutter/models/social_app/post_model/post_model.dart';

class FeedsScreen extends StatelessWidget {

  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
            condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
            builder: (context) =>  SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        const Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/horizontal-shot-joyful-young-woman-with-glasses-posing-against-white-wall_273609-20353.jpg?w=996&t=st=1689955779~exp=1689956379~hmac=5e89481b8c92331dffb636a6258b4432acb0cac73e6e00eea86dbb943e5f323d',
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 250.0,
                        ),
                        Text(
                          'Communicate with Friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.w600, height: 2.0),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index], context, index),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15.0,
                      ),
                      itemCount: SocialCubit.get(context).posts.length,
                  ),

                  const SizedBox(height: 8.0,),
                ],
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context ,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      model.image,
                    ),
                    radius: 25.0,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          model.dateTime,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 18.0,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1.0,
                ),
              ),
              Text(
                model.text,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 4.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 20.0,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: const Text(
              //                 '#software',
              //                 style:
              //                     TextStyle(color: Colors.blue, fontSize: 12.0),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 4.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 20.0,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: const Text(
              //                 '#flutter',
              //                 style:
              //                     TextStyle(color: Colors.blue, fontSize: 12.0),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      image: DecorationImage(
                          image: NetworkImage(
                            model.postImage,
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 16.0,
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.insert_comment_outlined,
                                color: Colors.amber,
                                size: 16.0,
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                /*${SocialCubit.get(context).comments[index]}*/ '0 comments',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1.0,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              SocialCubit.get(context).userModel!.image,
                            ),
                            radius: 18.0,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          // TextFormField(
                          //   controller: commentController,
                          //   decoration: InputDecoration(
                          //     border: InputBorder.none,
                          //     hintText: 'Write a comment ...',
                          //     hintStyle: Theme.of(context).textTheme.caption?.copyWith(height: 1.4),
                          //   ),
                          //   onFieldSubmitted: (value){
                          //
                          //   },
                          // ),
                          Text(
                            'Write a comment ...',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(height: 1.4),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 16.0,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          'like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.ios_share_outlined,
                          color: Colors.green,
                          size: 16.0,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          'share',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
