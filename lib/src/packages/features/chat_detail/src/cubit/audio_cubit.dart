import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayer _audioPlayer;

  AudioCubit(String audioUrl)
      : _audioPlayer = AudioPlayer(),
        super(const AudioState(
          isPlaying: false,
          audioDuration: Duration.zero,
          currentPosition: Duration.zero,
        )) {
    _init(audioUrl);
  }

  Future<void> _init(String audioUrl) async {
    try {
      Duration? duration = await _audioPlayer.setUrl(audioUrl);
      if (!isClosed) {
        emit(state.copyWith(audioDuration: duration ?? Duration.zero));
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(audioDuration: Duration.zero));
      }
    }

      _audioPlayer.positionStream.listen((position) {
      if (!isClosed) {
        emit(state.copyWith(currentPosition: position));
      }
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      if (!isClosed) {
        if (playerState.processingState == ProcessingState.completed) {
          emit(state.copyWith(
            isPlaying: false,
            currentPosition: Duration.zero,
          ));
        }
      }
    });
  }

  void togglePlayPause() {
    if (state.isPlaying) {
      _audioPlayer.pause();
    } else {
      if (state.currentPosition >= state.audioDuration) {
        _audioPlayer.seek(Duration.zero);
      }
      _audioPlayer.play();
    }
    emit(state.copyWith(isPlaying: !state.isPlaying));
  }

  void seekAudio(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
