# Load the binaural DSL operations we'd like to make use of
load(
    "//dsl:dsl.bzl",
    "binaural_stems",
    "binaural_sequence",
)

# First, we'll invoke the Scala CLI program to generate some "binaural stem tracks".
#
# A "binaural stem track" is a 2 channel (stereo) wav file containing a pure sine wave oscillating at some frequency on
# exactly one of the channels, with the other being blank. On it's own, there's nothing "binaural" about this audio file,
# but the CLI program will output two of these files which when taken together will have a binaural beat playing between
# them.
#
# The binaural CLI program is capable of interleaving these for us, but this is something we'll do manually
# in a later step for greater control and fidelity.

# Some shared parameters:
PITCH = 300     # 300 Hz
DURATION = 60   # 60 seconds

# This will generate two wav files (left+right) for an alpha wave binaural beat with a baseline pitch of `PITCH`
binaural_stems(
    name = "alpha-stems",
    pitch = PITCH,
    binaural_pitch = 10,
    duration = DURATION,
)

# This outputs two intermediate wav files for a beta wave binaural beat
binaural_stems(
    name = "beta-stems",
    pitch = PITCH,
    binaural_pitch = 20,
    duration = DURATION
)

# Next, we'll use these stem tracks as inputs to a Binaural Sequence.
#
# A Binaural Sequence generates a stereo wav file output from an input list of stem tracks. Each "stem" consists of
# two wav files (one for each channel) so these are first combined into a single merged stem track, and then each of these
# merged intermediate files are concatenated together in the order specified below to produce the final output audio file.

# Creates the final output, alpha-beta.wav
binaural_sequence(
    name = "alpha-beta-sequence",
    stems = [
        "//:alpha-stems",
        "//:beta-stems",
    ],
    crossfade = True,
    fade_in = True,
    fade_out = True
)

