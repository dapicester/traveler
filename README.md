
## Traveler

**Easily distribute your Ruby apps to any Linux and/or OS X.**

Traveler is about doing all hard work on packaging your Ruby apps into self-running containers using [Traveling Ruby](http://phusion.github.io/traveling-ruby/).

Not familiar with [Traveling Ruby](http://phusion.github.io/traveling-ruby/)?
Here are some [introductory materials](https://github.com/phusion/traveling-ruby#getting-started).

**Ok, what do i need to use Traveler?**

You'll need Ruby 2.1.x or 2.2.x on a Linux or OS X machine ([no windows support for now](https://github.com/sleewoo/traveler/issues/2)).

Why so?

Cause for now Traveling Ruby is distributing only these versions of Ruby and target containers should be built using same minor Ruby version.

Patch version may differ, but major and minor ones should match exactly.

## Install

```bash
$ gem install traveler
```

make sure to run `rbenv rehash` is you are using rbenv.

## Use

Traveler acts inside your app folder. It creates a `Travelfile` file and the `traveler` folder.

`Travelfile` is a Ruby file containing few configurations:

- `platforms`  specify what platforms your app should run on
- `wrapper` [define wrapper(s)](https://github.com/sleewoo/traveler/blob/master/skel/Travelfile#L12) that will allow to easily run your app
- `folder_name` name of the folder that will hold the builds (`traveler` by default)
- `traveling_ruby_version` what version of Traveling Ruby to be used for builds

And that's pretty all about configuration.

To generate a Travelfile run:

```bash
$ traveler init
```

This will also generate a Gemfile if it does not exists.

Now add a wrapper in your Travelfile and run:

```bash
$ traveler build
```

After build is done your app can be uploaded to server and run accordingly.

E.g. if your app resides in /path/to/my/app and you defined a wrapper named `run` in Travelfile, you can run your app with `/path/to/my/app/run`


## Multiple Ruby versions

Target Ruby version will match the Ruby version the runtime was built on.

So if you are on Ruby 2.1.x Traveler will build a 2.1.5 runtime.

And if you switch to Ruby 2.2.x, Traveler will build a 2.2.0 runtime, without touching the 2.1.5 one.

So you can have multiple Ruby versions with same app.

To make use of them simply define multiple wrappers, each using a specific Ruby version.


## Rewrapping

Sometimes you need to rebuild wrappers without actually rebuild the runtime/gems.

For this simply run:

`traveler wrap`

It will reread your wrappers in Travelfile and rebuild them accordingly.


## Contributors are highly welcome!

Would love to have some help with testing.

1. Fork it ( https://github.com/sleewoo/traveler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

Released under the MIT license, see LICENSE.txt for details.
