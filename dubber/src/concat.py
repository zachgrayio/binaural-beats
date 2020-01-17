import os
import sys
from pydub import AudioSegment


def main():
    print("Concatenating files...")
    # print(sys.argv)
    if len(sys.argv) < 3:
        _invalid_input()

    output_name = sys.argv[1]
    output_path = sys.argv[2]
    input_path = "."  # todo - better way of handling inputs than this lol

    if not os.path.isdir(input_path):
        print('The path specified does not exist')
        sys.exit(1)

    for (root, dirs, files) in os.walk(input_path):
        wav_files = [fn for fn in files if fn.endswith('.wav')]
        if len(wav_files) > 1:
            _concat_files(wav_files, "{fn}.wav".format(fn=output_name), root, output_path)


def _concat_files(wav_files, filename, dirname, output_path):
    if len(wav_files) != 2:
        print("expected 2 inputs!")
        sys.exit(1)

    first = AudioSegment.from_file(os.path.join(dirname, wav_files[0]))
    second = AudioSegment.from_file(os.path.join(dirname, wav_files[1]))
    base = AudioSegment.silent(duration=len(first) + len(second))

    merged = base.overlay(first)
    merged = merged.overlay(second, position=len(first))
    output = os.path.join(output_path, filename)
    print("Exporting concatenated audio file to {path}".format(path=output))
    merged.export(output, format='wav')
    sys.exit()


def _invalid_input():
    print('You must specify the path to merge')
    sys.exit()


if __name__ == '__main__':
    main()
