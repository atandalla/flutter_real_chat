part of 'audio_cubit.dart';

class AudioState extends Equatable {
  final bool isPlaying;
  final Duration audioDuration;
  final Duration currentPosition;

  const AudioState({
    required this.isPlaying,
    required this.audioDuration,
    required this.currentPosition,
  });

  AudioState copyWith({
    bool? isPlaying,
    Duration? audioDuration,
    Duration? currentPosition,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      audioDuration: audioDuration ?? this.audioDuration,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  @override
  List<Object?> get props => [isPlaying, audioDuration, currentPosition];
}
