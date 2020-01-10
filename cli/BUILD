load(
    "@io_bazel_rules_scala//scala:scala.bzl",
    "scala_binary",
)

scala_binary(
    name = "app",
    srcs = glob(["src/main/**/*.scala"]),
    main_class = "io.zachgray.binauralBeats.cli.BinauralApp",
    deps = [
        "//engine:engine",
        "@maven//:com_github_scopt_scopt_2_11",
    ],
    visibility = ["//visibility:public"]
)
