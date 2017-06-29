

# Binary dependencies needed for running the bash commands
DEPS = ["mvn", "openssl", "awk"]

# Assert that all relevant binaries are on class path
def _check_dependencies(ctx):
	for dep in DEPS:
		if ctx.which(dep) == None:
			fail("%s requires %s as a dependency. Please check your PATH." % (ctx.name, dep))

#TODO(petros): actually implement this.
def _transitive_maven_jar_impl(ctx):
	ctx.execute(["bash", "-c", "echo TODO. This is a placeholder"])

_common_maven_rule_attrs = {
	"artifact":attr.string(
		default="",
		mandatory=True,
	),
	"sha1":attr.string(default = ""),
}

transitive_maven_jar = repository_rule (
	implementation=_transitive_maven_jar_impl,
	attrs=_common_maven_rule_attrs + {
		"exclude":attr.string_list(mandatory=False),
	},
	local=False,
)
