import sys
from optparse import OptionParser


class Runner:
    def __init__(self, task, message):
        self.task = task
        self.message = message
        self.parser = create_parser()

    def run_task(self, *args):
        self.task(*args)

    def main(self):
        print(self.message)

        (options, input_files) = self.parser.parse_args()
        if len(input_files) < 2:
            _invalid_input()

        wav_files = [fn for fn in input_files if fn.endswith('.wav')]
        if len(wav_files) > 1:
            print("Processing .wav files:")
            print(wav_files)
            self.run_task(
                wav_files,
                "{fn}.wav".format(fn=options.name),
                options.path,
                options.crossfade,
                options.fade_in,
                options.fade_out
            )


def _invalid_input():
    print('Invalid input! Expected at least 2 positional args.')
    sys.exit()


def create_parser():
    parser = OptionParser()
    parser.add_option("-n", "--name", action="store", type="string", dest="name")
    parser.add_option("-p", "--path", action="store", type="string", dest="path")
    parser.add_option("-c", "--crossfade", action="store_true", dest="crossfade")
    parser.add_option("-f", "--fade_in", action="store_true", dest="fade_in")
    parser.add_option("-o", "--fade_out", action="store_true", dest="fade_out")
    return parser
