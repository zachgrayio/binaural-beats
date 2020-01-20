load("//dubber:macros/dubber.bzl", "dubber_genrule")

def binaural_sequence(name, stems):

    # merge left & right audio for each target stem
    output_targets = []
    for i, stem in enumerate(stems):
        _name = "{name}_{index}".format(name=name, index=i)
        dubber_genrule(
            name = _name,
            dubber_program = "overlay",
            srcs = [stem]
        )
        output_targets.append(":{name}".format(name=_name))

    # concatenate merged stems
    dubber_genrule(
        name = name,
        dubber_program = "concat",
        srcs = output_targets
    )
