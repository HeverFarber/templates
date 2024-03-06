package env0

# METADATA
# title: warn
# description: We just notify you that production will be down
warn[format(rego.metadata.rule())]

format(meta) := meta.description
