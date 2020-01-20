import os
import sys
from pydub import AudioSegment
from common import Runner


def concat_files(wav_files, filename, dirname, output_path):
    first = AudioSegment.from_file(os.path.join(dirname, wav_files[0]))
    second = AudioSegment.from_file(os.path.join(dirname, wav_files[1]))
    base = AudioSegment.silent(duration=len(first) + len(second))

    merged = base.overlay(first)
    merged = merged.overlay(second, position=len(first))
    output = os.path.join(output_path, filename)
    print("Exporting concatenated binaural sequence to {path}".format(path=output))
    merged.export(output, format='wav')
    sys.exit()


def main():
    runner = Runner(concat_files, "Concatenating binaural audio clips...")
    runner.main()


if __name__ == '__main__':
    main()
