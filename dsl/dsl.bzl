load(
    "//dsl/private:macros/stems.bzl",
    _binaural_stems = "binaural_stems"
)

load(
    "//dsl/private:macros/sequence.bzl",
    _binaural_sequence = "binaural_sequence"
)

binaural_stems = _binaural_stems
binaural_sequence = _binaural_sequence
