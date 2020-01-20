load("@pip//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary", "py_library")

py_binary(
    name = "overlay",
    main = "overlay.py",
    srcs = ["src/overlay.py"],
    deps = [
        ":common",
        requirement("pydub"),
    ],
    visibility = ["//visibility:public"],
)

py_binary(
    name = "concat",
    main = "concat.py",
    srcs = ["src/concat.py"],
    deps = [
        ":common",
        requirement("pydub"),
    ],
    visibility = ["//visibility:public"],
)

py_library(
    name = "common",
    srcs = glob(["src/common/**/*.py"]),
    deps = [],
)
