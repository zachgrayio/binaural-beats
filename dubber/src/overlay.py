import os
import sys
from pydub import AudioSegment
from common import Runner


def overlay_files(wav_files, filename, dirname, output_path):
    left = AudioSegment.from_file(os.path.join(dirname, wav_files[0]))
    right = AudioSegment.from_file(os.path.join(dirname, wav_files[1]))

    merged = left.overlay(right)
    output = os.path.join(output_path, filename)
    print("Exporting overlaid audio file to {path}".format(path=output))
    merged.export(output,  format='wav')
    sys.exit()


def main():
    runner = Runner(overlay_files, "Overlaying files...")
    runner.main()


if __name__ == '__main__':
    main()
