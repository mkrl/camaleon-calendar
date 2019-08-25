class Plugins::Calendar::FrontController < CamaleonCms::Apps::PluginsFrontController
  include Plugins::Calendar::MainHelper
  def index
    @date = parse_params
  end

  private

  def is_number?(string)
    /(\D+)/.match(string).nil?
  end

  def parse_params
    if is_number?(params[:m]) then
      case params[:m].length
      when 4
        find_year_posts(params[:m])
      when 6
        find_month_posts(params[:m])
      when 8
        find_day_posts(params[:m])
      else
        nil
      end
    else
      nil
    end
  end

  def calendar_posts
    current_site.post_types.find(current_site.get_meta('calendar_post_type')).posts
  end

  def find_year_posts(year)
    date = Date.new(year.to_i)
    calendar_posts.published.where(created_at: date..date.end_of_year)
  end

  def find_month_posts(month)
    year = month[0..3]
    month_t = month[4..5]
    date = Date.new(year.to_i, month_t.to_i)
    calendar_posts.published.where(created_at: date..date.end_of_month)
  end

  def find_day_posts(day)
    year = day[0..3]
    month = day[4..5]
    day_t = day[6..7]
    date = Date.new(year.to_i, month_t.to_i, day_t.to_i)
    calendar_posts.published.where(created_at: date..date.end_of_day)
  end

end
