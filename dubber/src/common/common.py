import sys


class Runner:
    def __init__(self, task, message):
        self.task = task
        self.message = message

    def run_task(self, *args):
        self.task(*args)

    def main(self):
        print(self.message)

        if len(sys.argv) < 5:
            _invalid_input()

        output_name = sys.argv[1]
        output_path = sys.argv[2]
        input_files = sys.argv[3:]

        wav_files = [fn for fn in input_files if fn.endswith('.wav')]
        if len(wav_files) > 1:
            print("Processing .wav files:")
            print(wav_files)
            self.run_task(wav_files, "{fn}.wav".format(fn=output_name), output_path)


def _invalid_input():
    print('Invalid input! Expected 4+ args: output_filename output_path src1 src2 [srcN ...]')
    sys.exit()
