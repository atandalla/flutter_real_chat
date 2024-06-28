import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:real_chat/src/packages/data/account/account.dart';
import 'package:real_chat/src/packages/features/profile/profile.dart';
import 'package:real_chat/src/packages/features/profile/src/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.sizeOf(context).height * 0.7;

    return Column(
      children: [
        Hero(
          tag: user.uid,
          child: ChateoAvatar(
            name: user.name ?? '',
            photoUrl: user.photoUrl,
            radius: ChateoDimens.dimen_36,
          ),
        ),
        Text(
          user.name ?? '',
          style: textTheme.labelLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: ChateoDimens.dimen_4,
        ),
        Text(
          user.email ?? '',
          style: textTheme.bodySmall?.copyWith(
            color: ChateoColors.darkGrey,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: ChateoDimens.dimen_40,
            horizontal: ChateoDimens.dimen_12,
          ),
          height: height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ChateoDimens.dimen_40),
              topRight: Radius.circular(ChateoDimens.dimen_40),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ProfileItem(
                title: 'Tu nombre:',
                subtitle: user.name,
              ),
              ProfileItem(
                title: 'Tu correo:',
                subtitle: user.email,
              ),
              ProfileItem(
                title: 'Tu celular:',
                subtitle: user.phoneNumber,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      context.read<ProfileBloc>().add(LogOutEvent(user)),
                  child: const Text('Cerrar Sesión'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
