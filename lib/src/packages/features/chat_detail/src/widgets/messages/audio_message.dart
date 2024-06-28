import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/audio_cubit.dart';

class AudioMessageWidget extends StatelessWidget {
  const AudioMessageWidget({
    Key? key,
    required this.audioUrl,
    required this.date,
    required this.mySelf,
    required this.name,
    required this.photoUrl,
  }) : super(key: key);

  final String audioUrl;
  final DateTime date;
  final bool mySelf;
  final String name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AudioCubit(audioUrl),
      child: AudioMessageView(
        date: date,
        mySelf: mySelf,
        name: name,
        photoUrl: photoUrl,
      ),
    );
  }
}

class AudioMessageView extends StatelessWidget {
  const AudioMessageView({
    Key? key,
    required this.date,
    required this.mySelf,
    required this.name,
    required this.photoUrl,
  }) : super(key: key);

  final DateTime date;
  final bool mySelf;
  final String name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = DateFormat.jm().format(date);

    return Row(
      mainAxisAlignment:
          mySelf ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!mySelf)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
              child: photoUrl == null ? Text(name[0]) : null,
            ),
          ),
        Column(
          crossAxisAlignment:
              mySelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: mySelf ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BlocBuilder<AudioCubit, AudioState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              state.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: mySelf ? Colors.white : Colors.black,
                            ),
                            onPressed: () =>
                                context.read<AudioCubit>().togglePlayPause(),
                          ),
                          Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            width: 140,
                            child: Slider(
                              thumbColor: Colors.orange,
                              activeColor: Colors.orangeAccent,
                              inactiveColor: Colors.white,
                              value: state.currentPosition.inSeconds.toDouble(),
                              max: state.audioDuration.inSeconds.toDouble(),
                              onChanged: (value) {
                                context.read<AudioCubit>().seekAudio(
                                    Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                          Text(
                            "${state.currentPosition.inMinutes}:${(state.currentPosition.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: textTheme.bodySmall?.copyWith(
                              color: mySelf ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            " / ",
                            style: textTheme.bodySmall?.copyWith(
                              color: mySelf ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            "${state.audioDuration.inMinutes}:${(state.audioDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: textTheme.bodySmall?.copyWith(
                              color: mySelf ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Text(
                    formattedDate.toLowerCase(),
                    style: textTheme.labelSmall?.copyWith(
                      color: mySelf ? Colors.white : Colors.grey[600],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}