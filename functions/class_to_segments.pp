# # `safe_include::class_to_segments`
#
# This function converts the name of a class into segments by splitting it on the '::'
#
# @param $class_name The name of the class
#
function safe_include::class_to_segments (
  String[1] $class_name,
) {
  $class_name.split('::')
}
