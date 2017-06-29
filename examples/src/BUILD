
load("@transitive_maven_jar_rule//:transitive_maven_jar_rule.bzl", "printer")
printer(
	name = "nothing",
	deps = [
		"BUILD",
		":other",
	],
)

printer(name="other")

java_binary(
	name = "empty",
	srcs = glob(["*.java"]),
	deps = []
)
