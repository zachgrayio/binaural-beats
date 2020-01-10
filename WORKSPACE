rules_scala_version="bd0c388125e12f4f173648fc4474f73160a5c628" # update this as needed

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

http_archive(
    name = "bazel_skylib",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
    ],
    sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
)
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()

http_archive(
    name = "io_bazel_rules_scala",
    strip_prefix = "rules_scala-%s" % rules_scala_version,
    type = "zip",
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
)

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories()

protobuf_version="09745575a923640154bcf307fba8aedff47f240a"
protobuf_version_sha256="416212e14481cff8fd4849b1c1c1200a7f34808a54377e22d7447efdf54ad758"

http_archive(
    name = "com_google_protobuf",
    url = "https://github.com/protocolbuffers/protobuf/archive/%s.tar.gz" % protobuf_version,
    strip_prefix = "protobuf-%s" % protobuf_version,
    sha256 = protobuf_version_sha256,
)

RULES_JVM_EXTERNAL_TAG = "3.0"
RULES_JVM_EXTERNAL_SHA = "62133c125bf4109dfd9d2af64830208356ce4ef8b165a6ef15bbff7460b35c3a"

http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    sha256 = RULES_JVM_EXTERNAL_SHA,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    name = "maven",
    artifacts = [
        "com.github.scopt:scopt_2.11:4.0.0-RC2",
        "junit:junit:4.12",
        "com.novocode:junit-interface:0.11",
        "org.scalaz:scalaz-core_2.11:7.2.7",
        "org.scalatest:scalatest_2.11:2.2.4",
        "org.apache.thrift:libthrift:0.9.3",
        "org.eclipse.jetty:jetty-servlet:9.4.0.M0",
        "org.eclipse.jetty:jetty-servlets:9.4.0.M0",
        "org.openjdk.jmh:jmh-core:1.12",
        "com.github.yannrichet:JMathPlot:1.0.1",
        "org.auroboros:signal-z_2.11:0.1.0",
        "org.clojars.sidec:jsyn:16.7.3",
        "org.apache.commons:commons-math3:3.6",
        "ch.qos.logback:logback-classic:1.1.7"
    ],
    repositories = [
        "https://jcenter.bintray.com/",
        "https://maven.google.com",
        "https://repo1.maven.org/maven2",
    ],
    maven_install_json = "//:maven_install.json",
)

load("@maven//:defs.bzl", "pinned_maven_install")
pinned_maven_install()

git_repository(
    name = "zachgrayio_scalaudio",
    commit = "6d7dfabd71392a6b15ff3eea8b86945b12ad20f5",
    remote = "http://github.com/zachgrayio/scalaudio.git",
    shallow_since = "1578573315 +1100"
)
