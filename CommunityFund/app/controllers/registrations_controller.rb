class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def edit
    prep_geo_communities
    @communities = Community.active
    super
  end

  def update
    prep_geo_communities
    @communities = Community.active
    super
  end

  protected
    def prep_geo_communities
      if @countries.blank?
        country_data = GeoInfo::countries.map { |c| [c.country, c.id] }
        @countries = Hash[*country_data.flatten]
      end

      community = self.resource.geo_community
      if not community.nil?
        country = GeoInfo::country_by_name(community.country)
        @selected_country = country.id
        city_data = GeoInfo::cities_for_country(country.id).map { |c| [c.city, c.id] }
        @cities = Hash[*city_data.flatten]
        @selected_city = community.id
      else
        @cities = []
        @selected_country = ''
        @selected_city = ''
      end
    end

    def update_resource(resource, update_params)
        if not update_params.has_key? :location
          resource.location = nil
          resource.save!
        end

        resource.community_ids = params[:user][:community_ids]
        resource.save!

        if update_params[:password].blank? and update_params[:password_confirmation].blank?
          resource.update_without_password(update_params)
        else
          resource.update(update_params)
        end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:email)
      devise_parameter_sanitizer.for(:account_update).push(:email, :location, :first_name, :last_name, :description, :avatar, :avatar_cache, :remove_avatar, :facebook_url, :twitter_url)
    end

    def after_sign_up_path_for(resource)
      '/users/edit'
    end

    def after_update_path_for(resource)
      '/users/' + resource.username
    end
end
