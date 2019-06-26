# # `safe_include::class_location`
#
# Returns the theoretical absolute location on disk for a given class but doesn't check that the file actually exists
#
# @param class_name The name of the class to find
#
function safe_include::class_location (
  String[1] $class_name,
) {
  # Segments of the class name
  $segments = safe_include::class_to_segments($class_name)

  if $segments.length > 1 {
    # Convert this into the relative path i.e. role::sevrer would become
    # role/manifests/server. Nore this is WITHOUT the .pp extension
    $class_path = $segments[1,-1].reduce('manifests') |$path, $segment| {
      "${path}/${segment}"
    }
  } else {
    # Handle scenarios where the class comes from init.pp
    $class_path = 'manifests/init'
  }

  # Get the path to the module
  $module_dir = module_directory($segments[0])

  # Return the value
  "${module_dir}/${class_path}.pp"
}
