load("//cli:macros/cli.bzl", "binaural_cli_genrule")

def binaural_stems(name, pitch, binaural_pitch, duration, **kwargs):
    binaural_cli_genrule(
        name = name,
        pitch = pitch,
        binaural_pitch = binaural_pitch,
        duration = duration,
        **kwargs
    )
