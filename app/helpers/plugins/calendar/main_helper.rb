include CamaleonCms::SiteHelper
module Plugins::Calendar::MainHelper

  def week_days
    t('date.day_names')
  end

  def week_days_ordered
    if current_site.get_meta("calendar_week_start") == 1
      wdo = week_days.dup
      firsdayize(wdo)
    else
      week_days
    end
  end

  def week_days_abbr_ordered
    if current_site.get_meta("calendar_week_start") == 1
      wdo = t('date.abbr_day_names').dup
      firsdayize(wdo)
    else
      t('date.abbr_day_names')
    end
  end

  def month_table(date)
    length = date.end_of_month.day
    offset = dotw_index(date.beginning_of_month)
    format_calendar(offset, length)
  end

  def months
    # A workaround to remove the first element of the array (why is it even 'nil'?)
    t('date.month_names').drop(1)
  end

  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  # here all actions on going to active
  def calendar_on_active(plugin)
  end

  def calendar_shortcodes
    shortcode_add("calendar_view", plugin_view('partials/calendar_view'), 'Render calendar')
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def calendar_on_inactive(plugin)
  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def calendar_on_upgrade(plugin)
  end

  # hook listener to add settings link below the title of current plugin (if it is installed)
  # args: {plugin (Hash), links (Array)}
  # permit to add unlimmited of links...
  def calendar_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_calendar_settings_path)
  end

  private

  def firsdayize(week)
    week.insert(6, week.delete_at(0))
  end

  def dotw_index(date)
    week_days_abbr_ordered.index(l(date, format: '%a' ))    
  end
  
  # TODO: update with model scope for better performance
  def current_post(day)
    unless day.nil?
      date = Date.new(Time.now.year, Time.now.month, day)
      posts = current_site.post_types.find(current_site.get_meta('calendar_post_type')).posts
      posts.published.where(created_at: date.beginning_of_day..date.end_of_day).first
    end
  end

  def event_exists_in_current_month?(day)
    unless day.nil?
      date = Date.new(Time.now.year, Time.now.month, day)
      posts = current_site.post_types.find(current_site.get_meta('calendar_post_type')).posts
      posts.published.where(created_at: date.beginning_of_day..date.end_of_day).any?
    end
  end

  def format_calendar(offset, month_length)
    lines = []
    dates = [nil] * offset + (1..month_length).to_a
    dates.each_slice(7) do |week|
      lines << week.map { |day| event_exists_in_current_month?(day) ? link_to(day.to_s, current_post(day).decorate.the_url) : day.to_s }
    end
    lines
  end
end
