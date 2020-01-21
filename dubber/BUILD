load("@pip//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary", "py_library")

py_binary(
    name = "overlay",
    srcs = ["src/overlay.py"],
    main = "overlay.py",
    visibility = ["//visibility:public"],
    deps = [
        ":common",
        requirement("pydub"),
    ],
)

py_binary(
    name = "concat",
    srcs = ["src/concat.py"],
    main = "concat.py",
    visibility = ["//visibility:public"],
    deps = [
        ":common",
        requirement("pydub"),
    ],
)

py_library(
    name = "common",
    srcs = glob(["src/common/**/*.py"]),
    deps = [],
)
