def dubber_genrule(name, dubber_program, srcs, crossfade, fade_in, fade_out):
    native.genrule(
        name = name,
        srcs = srcs,
        cmd = "./$(location //dubber:{program}) -n {name} -p $(@D) {c} {fi} {fo} $(SRCS)".format(
            name = name,
            program = dubber_program,
            c = "-c" if crossfade else "",
            fi = "-f" if fade_in else "",
            fo = "-o" if fade_out else "",
        ),
        outs = [
            "{name}.wav".format(
                name = name,
            ),
        ],
        tools = [
            "//dubber:{program}".format(program = dubber_program),
        ],
        visibility = ["//visibility:public"],
        executable = True,
    )
