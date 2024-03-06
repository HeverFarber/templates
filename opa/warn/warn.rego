package env0

# METADATA
# title: allow always
# description: I just notifu you that production will be broken
warn[format(rego.metadata.rule())]

format(meta) := meta.description
