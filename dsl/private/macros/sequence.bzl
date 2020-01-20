load("//dubber:macros/dubber.bzl", "dubber_genrule")

def binaural_sequence(name, stems, crossfade = False, fade_in = False, fade_out = False):

    # merge left & right audio for each target stem
    output_targets = []
    for i, stem in enumerate(stems):
        _name = "{name}_{index}".format(name=name, index=i)
        dubber_genrule(
            name = _name,
            dubber_program = "overlay",
            srcs = [stem],
            crossfade = crossfade,
            fade_in = fade_in,
            fade_out = fade_out
        )
        output_targets.append(":{name}".format(name=_name))

    # concatenate merged stems
    dubber_genrule(
        name = name,
        dubber_program = "concat",
        srcs = output_targets,
        crossfade = crossfade,
        fade_in = fade_in,
        fade_out = fade_out
    )
