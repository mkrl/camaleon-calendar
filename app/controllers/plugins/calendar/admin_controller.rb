class Plugins::Calendar::AdminController < CamaleonCms::Apps::PluginsAdminController

  def index
  end

  def settings
    @calendar_type = current_site.get_meta('calendar_post_type')
    @dotw = current_site.get_meta('calendar_week_start')
  end

  def save_settings
    @plugin.set_field_values(params[:field_options]) if params[:field_options].present? # save custom field values
    current_site.set_meta("calendar_post_type", params[:options][:calendar_post_type])
    current_site.set_meta("calendar_week_start", params[:options][:calendar_week_start])
    redirect_to url_for(action: :settings), notice: t('plugin.calendar.settings_save_notice')
  end
end
