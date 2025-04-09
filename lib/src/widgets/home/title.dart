import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';

class TitleName extends StatelessWidget {
  final bool isTablet;
  const TitleName({super.key, required this.isTablet});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(right: 8), // Border width
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(isTablet ? 28 : 18),
                  child: Image.network(
                    state.pic,
                    fit: BoxFit.cover,
                    height: 50,
                    scale: 0.7,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                state.display,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: isTablet ? 28 : 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
