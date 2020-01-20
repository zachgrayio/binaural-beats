

def binaural_clip_stems(name, pitch, binaural_pitch, duration, **kwargs):
    native.genrule(
        name = name,
        outs = ["{name}_0.wav".format(name=name), "{name}_1.wav".format(name=name)],
        cmd = "./$(location //cli:app) -p {pitch} -b {binaural_pitch} -d {duration} -f $(RULEDIR)/{name} -s".format(
            pitch = pitch,
            binaural_pitch = binaural_pitch,
            duration = duration,
            name = name
        ),
        tools = ["//cli:app"],
        visibility = ["//visibility:public"],
        **kwargs
    )


def binaural_sequence(name, srcs):

    # merge left & right audio for each target stem
    output_targets = []
    for i, input_target in enumerate(srcs):
        _name = "{name}_{index}".format(name=name, index=i)
        dubber_genrule(
            name = _name,
            dubber_program = "overlay",
            srcs = [input_target]
        )
        output_targets.append(":{name}".format(name=_name))

    # concatenate merged stems
    dubber_genrule(
        name = name,
        dubber_program = "concat",
        srcs = output_targets
    )


def dubber_genrule(name, dubber_program, srcs):
    native.genrule(
        name = name,
        srcs = srcs,
        cmd = "./$(location //dubber:{program}) {output_name} $(@D)".format(
            output_name = name,
            program = dubber_program
        ),
        outs = [
            "{output_name}.wav".format(
                output_name = name
            )
        ],
        tools = [
            "//dubber:{program}".format(program=dubber_program)
        ],
        visibility = ["//visibility:public"],
        executable = True
    )
