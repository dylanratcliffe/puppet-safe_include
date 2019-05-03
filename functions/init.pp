# # safe_include function
#
# This function takes a class name or list of classes in array or string format and the includes them if they exist and skips them if they
# don't.
#
# param classes The list of classes to include
#
function safe_include (
  Variant[String,Array[String]] $classes,
) {
  # Convert the param to an array regardless of format
  $classes_array = [$classes].flatten

  $classes_array.each |$class| {
    if safe_include::class_exists($class) {
      include $class
    }
  }
}
