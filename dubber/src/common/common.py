import os
import sys


class Runner:
    def __init__(self, task, message):
        self.task = task
        self.message = message

    def run_task(self, *args):
        if len(args[0]) != 2:
            print("expected 2 inputs!")
            sys.exit(1)
        self.task(*args)

    def main(self):
        print(self.message)

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
                self.run_task(wav_files, "{fn}.wav".format(fn=output_name), root, output_path)


def _invalid_input():
    print('You must specify the path to merge')
    sys.exit()
