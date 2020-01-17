

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


def binaural_sequence(name, srcs, **kwargs):

    # merge left & right audio for each target stem
    _srcs = []
    for i, src in enumerate(srcs):
        _name = "{name}_{index}".format(name=name, index=i)
        native.genrule(
            name = _name,
            srcs = [src],
            cmd = "./$(location //dubber:overlay) {output_name} $(@D)".format(
                output_name = _name,
            ),
            outs = [
                "{output_name}.wav".format(
                    output_name = _name
                )
            ],
            tools = [
                "//dubber:overlay"
            ],
            visibility = ["//visibility:public"],
            executable = True,
            **kwargs
        )
        _srcs.append(":{name}".format(name=_name))

    # concatenate merged stems
    native.genrule(
        name = name,
        srcs = _srcs,
        cmd = "./$(location //dubber:concat) {output_name} $(@D)".format(
            output_name = name,
        ),
        outs = [
            "{output_name}.wav".format(
                output_name = name
            )
        ],
        tools = [
            "//dubber:concat"
        ],
        visibility = ["//visibility:public"],
        executable = True,
    )
