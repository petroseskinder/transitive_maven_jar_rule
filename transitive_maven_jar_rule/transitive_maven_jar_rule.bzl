
# Binary dependencies needed for running the bash commands
DEPS = ["mvn", "openssl", "awk"]

# helper function to encapsulate bash commands.
def _execute(ctx, command):
	return ctx.execute(["bash", "-c", """
set -ex
%s""" % command])

# Assert that all relevant binaries are on class path
#TODO(petros): how should I depend on the migration_tool project. Should I fetch it like I do bazel.
def _check_dependencies(ctx):
	for dep in DEPS:
		if ctx.which(dep) == None:
			fail("%s requires %s as a dependency. Please check your PATH." % (ctx.name, dep))

#TODO(petros): actually implement this.
#TODO(petros): how to integrate the migration_tool and then call shell command use it.
def _transitive_maven_jar_impl(ctx):
	print("Checking if dependencies are met.")
	_check_dependencies(ctx)

_common_maven_rule_attrs = {
	"artifact":attr.string(
		default="",
		mandatory=True,
	),
	"sha1":attr.string(default = ""),
}


def _printer_impl(ctx):
	print("Rule name = %s, package = %s" % (ctx.label.name, ctx.label.package))
	print("There are %d deps" % len(ctx.attr.deps))
	for i in ctx.attr.deps:
		print("- %s" % i.label)
		print(" files = %s" % [f.path for f in i.files])

printer = rule(
	implementation=_printer_impl,
	attrs={
		"number":attr.int(default = 1),
		"deps":attr.label_list(allow_files=True),
	}
)


transitive_maven_jar = repository_rule (
	implementation=_transitive_maven_jar_impl,
	attrs=_common_maven_rule_attrs + {
		"exclude":attr.string_list(mandatory=False),
		"generate_workspace_tool" : attr.label(executable=True, cfg="host", 
												default=Label("//pkg:generate_workspace"))
	},
	local=False,
)
