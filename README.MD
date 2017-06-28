# Transitive Maven Rule
### Rules
* [transitive_maven_jar](google.com)
* [transitive_maven_server](google.com)
### Overview 
This bazel repository rule extends the maven_jar rule so that it fetches
the jar for the specified maven_coordinate as well as its transitive
dependencies.

### Getting Started
In order to use `transitive_maven_jar` you must have the `migration_tool` and add the following to your WORKSPACE file:

```python
	rule_version="TODO" #update this as needed

	http_archive(
		name = "transitive_maven_jar",
		url = "https://github.com/petroseskinder/transitive_maven_jar/archive/%s.zip"%rule_version, 
		type = "zip",
		strip_prefix = "transitive_maven_jar-%s" % rule_version
	)

	load("transitive_maven_jar//transitive_maven_jar_rule.bzl", "transitive_maven_jar")

```

### Basic Example
This is a simple example using junit. Place this in your WORKSPACE file.

```python

load("@transitive_maven_jar_rule//:transitive_maven_jar_rule.bzl", "transitive_maven_jar")

//example using junit-4.12
transitive_maven_jar(
	name = "junit",
	artifact = "junit:junit:4.12",
)

```

### Future Work
Add support for using private servers. We want to specify that the jar should be downloaded from a 
private network. It will be assumed that authentication information can be found in ~/.m2/settings.xml

If no server is specified, then this tool should fetch from Maven Central with no authentication enabled.

```python
maven_server(
	name = "my_server",
	url = "http://intranet.mycorp.net",
)
```
