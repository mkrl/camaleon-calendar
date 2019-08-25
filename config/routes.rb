require 'plugin_routes'
require 'camaleon_cms/engine'
Rails.application.routes.draw do
  scope PluginRoutes.system_info["relative_url_root"] do
    scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
      # TODO: pass path as explict routes like "/calendar/2019/06/29"
      namespace 'calendar' do
        # get 'index' => 'front#index'
        # get "events/:year/:month/:day" => "events#day", 
        #     :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ },
        #     :as => "events_day"
        # get "events/:year/:month/:day" => "events#month", 
        #    :constraints => { :year => /\d{4}/, :month => /\d{2}/ },
        #    :as => "events_month"
        # get "events/:year/" => "events#year", 
        #    :constraints => { :year => /\d{4}/ },
        #    :as => "events_year"
      end
    end

    #Admin Panel
    scope :admin, as: 'admin', path: PluginRoutes.system_info['admin_path_name'] do
      namespace 'plugins' do
        namespace 'calendar' do
          controller :admin do
            get :settings
            post :save_settings
          end
        end
      end
    end

    # Currently passing date as a part of the URL and then parsing it in the controller
    scope 'calendar', module: 'plugins/calendar', as: 'calendar' do
      get '/' => 'front#index'
    end
  end
end
