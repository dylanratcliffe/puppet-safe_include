
# safe_include

It's like the `include` function but safer. Maybe...

Basically it won't fail if the class doesn't exist.

## Description

To use this simply pass a class to the function and it will get included if it exists:

```puppet
safe_include('profile::maybe::exists')
```

Or you can pass an array:

```puppet
$classes = [
  'profile::docker',
  'profile::mysql',
  'profile::typo4',
]

safe_include($classes)
```

## Why would anyone want this?

Good question. Maybe you are consuming a free text field from an API and don't want the entire catalog compilation to fail if someone made a typo. Maybe you are refactoring roles from one naming convention to another and you want the classification to keep working even if the name changes.

## Reference

TODO