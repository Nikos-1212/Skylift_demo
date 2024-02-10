import 'package:demo/bloc/timer_bloc/cubit/timer_cubit.dart';
import 'package:demo/bloc/user_bloc/get_user_bloc.dart';
import 'package:demo/view/timer_page.dart';
import 'package:demo/view/user_details.dart';
import 'package:demo/widgets/textfield_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_cupertino_dialog.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User list'),
        actions: [
          IconButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const TimerPage()));
          }, icon:const Icon(Icons.timer_sharp))
        ],
      ),
      body: _userList(context),
    );
  }

  Widget _userList(context) {
    return BlocBuilder<GetUserBloc, GetUserState>(
      builder: (contexttt, state) {
        if (state is GetUserLoading) {
          return const Center(
            child: SizedBox(
                height: 28, width: 28, child: CircularProgressIndicator()),
          );
        } else if (state is GetUserError) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else if (state is GetUserLoaded) {
          final userList = state.userModel.records;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
                itemCount: userList?.length ?? 0,
                itemBuilder: (_, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        if (userList != null && userList.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserDetails(userRecord: userList[index]),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey.withOpacity(0.3)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userList![index].name ?? ''),
                                    const SizedBox(
                                      height: 8.5,
                                    ),
                                    Text(userList[index].email ?? ''),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () async {
                                      final List res = await showDialog(
                                        context: contexttt,
                                        builder: (BuildContext context) {
                                          return TextFieldDialog(
                                            title: 'Edit Fields',
                                            nameHintText: 'Name',
                                            emailHintText: 'Email',
                                            nameField: TextEditingController(
                                                text:
                                                    userList[index].name ?? ''),
                                            emailField: TextEditingController(
                                                text: userList[index].email ??
                                                    ''),
                                          );
                                        },
                                      );
                                      if (res != [] && res.length == 2) {
                                        // ignore: use_build_context_synchronously
                                        BlocProvider.of<GetUserBloc>(contexttt)
                                            .add(GetuserUpdateevent(
                                                index, res[0], res[1]));
                                      }
                                    },
                                    child: const Icon(Icons.edit)),
                                const SizedBox(
                                  height: 12,
                                ),
                                InkWell(
                                    onTap: () {
                                      _delete(contexttt, index, context)
                                          .whenComplete(() => null);
                                    },
                                    child: const Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              width: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return Center(
            child: Text(state.toString()),
          );
        }
      },
    );
  }

  Future<void> _delete(contexttt, int index, context) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomCupertinoDialog(
            title: 'Delete User',
            content: 'Are you sure you want to delete it?',
            hasTwoButtons: true,
            button1Text: 'Yes',
            button2Text: 'No',
            button1Action: () async {
              Navigator.of(context, rootNavigator: true).pop('Discard');
              try {
                BlocProvider.of<GetUserBloc>(contexttt)
                    .add(GetuserDeleteevent(index));
                // context.read<GetUserBloc>().add(GetuserDeleteevent(index));
              } catch (e) {
                print(e.toString());
              }
              // Handle button 1 action
            },
            button2Action: () {
              Navigator.of(contexttt, rootNavigator: true).pop('Discard');

              // Handle button 2 action
            },
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(contexttt).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
