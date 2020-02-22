# Redmine like plugin
This plugin allows you to send the like on Redmine. It is a very simple plugin, so please modify it freely.

## What's new
* Fix problem with sub-URI configuration.
* You can chose an icon from 6 design.

## Features
* You can like tickets, notes and wikis.
* e-mail notifications when someone likes you.
* Animated icons.

## Screenshots

### Type of icons
<img src="./assets/images/type_of_icons.png" width="305px">

### Like Total
<img src="./assets/images/like_total.png" width="600px">

## Install

1. Move to plugins folder.

2. Put the code.
<pre>
git clone https://github.com/happy-se-life/like.git
</pre>

3. Run migration.
<pre>
bundle exec rake redmine:plugins:migrate NAME=like RAILS_ENV=production
</pre>

4. Edit models/LikeConstants.rb to chose icon type.

5. Restart redmine.

## Uninstall

1. Move to plugins folder.

2. Rollback migration.
<pre>
bundle exec rake redmine:plugins:migrate NAME=like VERSION=0 RAILS_ENV=production
</pre>

3. Remove plugins folder.
<pre>
rm -rf like
</pre>

4. Restart redmine.

## Limitation
* Only supports English and Japanese.
* This is an experimental plugin.

## License
* MIT Lisense
