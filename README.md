Cyclid Bundler Plugin
=====================

A simple Action plugin for Cyclid which provides a way to run a command under
"bundle exec" without having to repeat the command in every Step; this plugin
wraps the core Command plugin, so the functionality in this plugin is minimal.

# Installation

Install the plugin and restart Cyclid

```
$ gem install cyclid-bundler-plugin
$ service cyclid restart
```

# Usage

The arguments are the same as the Cyclid Command plugin; see 
[http://docs.cyclid.io/en/latest/plugins/actions.html#command]()

The `bundler` Gem must be installed; if necasary you should define a Stage or
Step within an existing Stage which will install Bundler.

## Examples

To run the (literal) command "bundle exec rake spec" as a Stage:

```
  {
    "name": "test",
    "steps": [
      {
        "action": "bundler",
        "cmd": "rake spec",
        "path": "%{workspace}/MyProject"
      }
    ]
  }
```
