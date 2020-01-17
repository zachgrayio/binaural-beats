load("@pip//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary")

py_binary(
    name = "overlay",
    main = "overlay.py",
    srcs = ["src/overlay.py"],
    deps = [
      requirement("pydub"),
    ],
    visibility = ["//visibility:public"],
)

py_binary(
    name = "concat",
    main = "concat.py",
    srcs = ["src/concat.py"],
    deps = [
      requirement("pydub"),
    ],
    visibility = ["//visibility:public"],
)
