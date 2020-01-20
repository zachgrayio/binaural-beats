import os
from pydub import AudioSegment
from common import Runner


def concat_files(wav_files, filename, output_path, crossfade, fade_in, fade_out):
    crossfade_ms = 3000 if crossfade else 0
    fade_in_ms = 5000 if fade_in else 0
    fade_out_ms = 5000 if fade_out else 0
    output = AudioSegment.from_file(wav_files[0])

    for wav in wav_files[1:]:
        output = output.append(AudioSegment.from_file(wav), crossfade=crossfade_ms)

    faded = output.fade_in(fade_in_ms).fade_out(fade_out_ms)

    print("Exporting concatenated binaural sequence to {path}".format(path=output_path))
    faded.export(os.path.join(output_path, filename), format='wav')


def main():
    runner = Runner(concat_files, "Concatenating binaural audio clips...")
    runner.main()


if __name__ == '__main__':
    main()
