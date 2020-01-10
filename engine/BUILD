load(
    "@io_bazel_rules_scala//scala:scala.bzl",
    "scala_library",
)

scala_library(
    name = "engine",
    srcs = glob(["src/main/**/*.scala"]),
    deps = [
        "@zachgrayio_scalaudio//scalaudio-amp:scalaudio-amp",
    ],
    exports = [
        "@zachgrayio_scalaudio//scalaudio-amp:scalaudio-amp",
    ],
    visibility = ["//visibility:public"]
)
