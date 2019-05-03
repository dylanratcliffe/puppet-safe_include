# # `safe_include::class_exists`
#
# Checks if a given class actually exists on disk. Note that this currently doesn't *actually* check if the class exists. It checks if the
# file exists and search for the class name. There are many dumb situations where the class wouldn't actually exist and this might fail e.g.
#
#   * The file contains a commented out class
#   * The file contains just the class name and nothing else
#   * The file contains the class name and some emojis and nothing else
#   * The file is binary but we still manage to find the class name somehow
#
# Please don't do these things ^
#
# @param name The name of the class to check
#
function safe_include::class_exists (
  String $name,
) {
  # Get the location of the file theoretically
  $location = safe_include::class_location($name)

  # Check if it's there
  $content  = file($location,'safe_include/empty')

  # Return the result! The poop emoji is returned if the file isn't found
  if $content == 'Not Found!!!' {
    false
  } elsif $content =~ String {
    true
  }
}
