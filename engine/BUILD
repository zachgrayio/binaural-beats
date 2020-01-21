load(
    "@io_bazel_rules_scala//scala:scala.bzl",
    "scala_library",
)

scala_library(
    name = "engine",
    srcs = glob(["src/main/**/*.scala"]),
    visibility = ["//visibility:public"],
    exports = [
        "@zachgrayio_scalaudio//scalaudio-amp",
    ],
    deps = [
        "@zachgrayio_scalaudio//scalaudio-amp",
    ],
)
