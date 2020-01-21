def binaural_cli_genrule(name, pitch, binaural_pitch, duration, **kwargs):
    native.genrule(
        name = name,
        outs = ["{name}_0.wav".format(name = name), "{name}_1.wav".format(name = name)],
        cmd = "./$(location //cli:app) -p {pitch} -b {binaural_pitch} -d {duration} -f $(RULEDIR)/{name} -s".format(
            pitch = pitch,
            binaural_pitch = binaural_pitch,
            duration = duration,
            name = name,
        ),
        tools = ["//cli:app"],
        visibility = ["//visibility:public"],
        **kwargs
    )
