load("//dubber:macros/dubber.bzl", "dubber_genrule")


def binaural_sequence(name, stems, crossfade = False, fade_in = False, fade_out = False):
    sequence = struct(
        name = name,
        stems = stems,
        crossfade = crossfade,
        fade_in = fade_in,
        fade_out = fade_out
    )
    # phase 1: merge left & right audio for each target stem
    phase_2_targets = phase_1_overlay_stems(sequence)
    # phase 2: concatenate merged stems
    phase_2_concat_all_stems(sequence, phase_2_targets)


def phase_1_overlay_stems(sequence):
    # collect list of generated targets for use in later phases
    output_targets = []
    # generate overlay/merge program targets for every stem
    for i, stem in enumerate(sequence.stems):
        stem_name = stem.split(":")[1]
        overlay_macro_name = "{}_{}".format(sequence.name, stem_name)
        # if the same stem is passed twice, avoid collision
        # todo: determine if there's a way to avoid this for better caching
        if ":" + overlay_macro_name in output_targets:
            overlay_macro_name = "{}_{}".format(overlay_macro_name, i)
        dubber_genrule(
            name = overlay_macro_name,
            dubber_program = "overlay",
            srcs = [stem],
            crossfade = sequence.crossfade,
            fade_in = sequence.fade_in,
            fade_out = sequence.fade_out
        )
        output_targets.append(":{}".format(overlay_macro_name))
    return output_targets


def phase_2_concat_all_stems(sequence, phase_2_targets):
    dubber_genrule(
        name = sequence.name,
        dubber_program = "concat",
        srcs = phase_2_targets,
        crossfade = sequence.crossfade,
        fade_in = sequence.fade_in,
        fade_out = sequence.fade_out
    )
