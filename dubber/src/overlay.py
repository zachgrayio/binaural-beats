import os
from pydub import AudioSegment
from common import Runner


def overlay_files(wav_files, filename, output_path):
    left = AudioSegment.from_file(wav_files[0])
    right = AudioSegment.from_file(wav_files[1])

    merged = left.overlay(right)
    output = os.path.join(output_path, filename)
    print("Exporting merged binaural clip to {path}".format(path=output))
    merged.export(output,  format='wav')


def main():
    runner = Runner(overlay_files, "Merging left & right binaural stems...")
    runner.main()


if __name__ == '__main__':
    main()
