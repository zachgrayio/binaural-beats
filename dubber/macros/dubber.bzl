def dubber_genrule(name, dubber_program, srcs):
    native.genrule(
        name = name,
        srcs = srcs,
        cmd = "./$(location //dubber:{program}) {output_name} $(@D) $(SRCS)".format(
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
