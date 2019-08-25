# Calendar
Camaleon CMS calendar plugin

## Installation
Clone into `apps/plugins` and add plugin paths to your project Gemfile:
```ruby
# ...end of your Gemfile
require './lib/plugin_routes' 
instance_eval(PluginRoutes.draw_gems)
# ...
gem 'calendar', path: 'apps/plugins/calendar'
```

## Usage

You can render your calendar partial with `[calendar_view]` shortcode anywhere you want.
Set up you preferred post type to be used as post source for the plugin and then navigate / link to `/calendar?m=[date]`, where date follows the `yearmonthday` format. For example:

 - `2019` will show posts just from the entire 2019
 - `201906` will query for posts in June 2019
 - `20190629` will show posts from June 29 2019

This was coded as an emergency solution so it's not recommended to be used in production unless heavily modified and tested.
Be sure to modify your base calendar view @ `/app/views/plugins/calendar/front/index.html.erb` in order to properly render your posts.