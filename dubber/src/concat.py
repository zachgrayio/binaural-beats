import os
from pydub import AudioSegment
from common import Runner


def concat_files(wav_files, filename, output_path):
    first = AudioSegment.from_file(wav_files[0])
    second = AudioSegment.from_file(wav_files[1])
    base = AudioSegment.silent(duration=len(first) + len(second))

    merged = base.overlay(first)
    merged = merged.overlay(second, position=len(first))
    output = os.path.join(output_path, filename)
    print("Exporting concatenated binaural sequence to {path}".format(path=output))
    merged.export(output, format='wav')


def main():
    runner = Runner(concat_files, "Concatenating binaural audio clips...")
    runner.main()


if __name__ == '__main__':
    main()