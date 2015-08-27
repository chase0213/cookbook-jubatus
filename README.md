Chef cookbook for Jubatus
=========================

This cookbook is a library cookbook to install or configure jubatus server and client, supporting Chef 12.x and higher.
It is supposed to be used this by wrapped in your own cookbook.

Usage
------

First of all, you need to create your own cookbook,
and add following line to your cookbook:

```ruby
depends 'jubatus'
```

Then, you can use resources provided by this cookbook.
Available resources are listed on below.

Resources
----------

#### jubatus_user

Actions: `:create`, `:remove`

Creates or removes user and group for jubatus.

Examples:

```
jubatus_user 'jubatus' do
  username 'jubatus'
end
```

```
jubatus_user 'jubatus' do
  shell '/bin/bash'
  home_dir '/home/jubatus'
  groupname 'ml'
  action :create
end
```

#### jubatus_install

Actions: `:install`, `:remove`

Downloads the jubatus server or client, and install to the system.
So far, installation via `package` is only provided.

Examples:

```ruby
jubatus_install 'jubatus installation' do
  type :package
  version '0.8.0-1.el6'
  action :install
end
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License
-------

- MIT License

