module Gmaps4rails
  
  class ViewHelper
    
    OPENLAYERS = "http://www.openlayers.org/api/OpenLayers.js"
    MAPQUEST   = "http://mapquestapi.com/sdk/js/v6.0.0/mqa.toolkit.js"
    BING       = "http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"
    GOOGLE     = "//maps.google.com/maps/api/js?v=3.8"
    GOOGLE_EXT = "//google-maps-utility-library-v3.googlecode.com/svn/"    
    
    def initialize(options = {})
      @options  = options
      @js_array = Array.new
    end
    
    def js_dependencies_array
      if scripts != :none
        get_vendor_scripts
        get_gem_scripts
      end
      @js_array
    end
    
    def dom_attributes
      @dom_attr = OpenStruct.new({
        :map_id          => map_id,
        :map_class       => map_class,
        :container_class => container_class,
        :provider        => map_provider
      })
    end
    
    private
    
    def get_gem_scripts
      unless gmaps4rails_pipeline_enabled?
        @js_array << '/gmaps4rails/gmaps4rails.base.js' unless scripts == :api
        @js_array << case map_provider
                     when "openlayers" then '/gmaps4rails/gmaps4rails.openlayers.js'
                     when "mapquest"   then '/gmaps4rails/gmaps4rails.mapquest.js'
                     when "bing"       then '/gmaps4rails/gmaps4rails.bing.js'
                     else                   '/gmaps4rails/gmaps4rails.googlemaps.js'
                     end
      end
    end
    
    def get_vendor_scripts
      case map_provider
      when "openlayers"  then @js_array << OPENLAYERS
      when "mapquest"    then @js_array << "#{MAPQUEST}?key=#{provider_key}"
      when "bing"        then @js_array << BING
      else #case googlemaps which is the default
        @js_array << "#{GOOGLE}&sensor=false&key=#{provider_key}&libraries=geometry#{google_libraries}&#{google_map_i18n}"
        @js_array << "#{GOOGLE_EXT}tags/infobox/1.1.9/src/infobox_packed.js"                     if custom_infowindow_class
        @js_array << "#{GOOGLE_EXT}tags/markerclustererplus/2.0.5/src/markerclusterer_packed.js" if do_clustering
        @js_array << "#{GOOGLE_EXT}trunk/richmarker/src/richmarker-compiled.js"                  if rich_marker
      end
    end
        
    # checks whether or not the app has pipeline enabled
    # works works Rails 3.0.x and above
    # @return [Boolean]
    def gmaps4rails_pipeline_enabled?
      Rails.configuration.methods.include?(:assets) && Rails.configuration.assets.enabled
    end
    
    def map_options
      @map_options ||= @options[:map_options]
    end
    
    def marker_options
      @marker_options ||= @options[:markers].try(:[],:options)
    end
    
    def map_provider
      @map_provider ||= map_options.try(:[], :provider)
    end
    
    def scripts
      @scripts ||= @options[:scripts].try(:to_sym)
    end
    
    def provider_key
      map_options.try(:[], :provider_key)
    end
    
    def custom_infowindow_class
      marker_options.try(:[], :custom_infowindow_class)
    end
    
    def do_clustering
      marker_options.try(:[], :do_clustering)
    end
    
    def google_libraries
      libraries_array = map_options.try(:[], :libraries)
      return "" if libraries_array.nil?
      "," + libraries_array.join(",")
    end

    def google_map_i18n
      "language=#{language}&hl=#{hl}&region=#{region}"
    end
    
    def language
      map_options.try(:[], :language)
    end
    
    def hl
      map_options.try(:[], :hl)
    end
    
    def region
      map_options.try(:[], :region)
    end
    
    def rich_marker
      marker_options.try(:[], :rich_marker)
    end
    
    def map_id
      map_options.try(:[], :id) || Gmaps4rails::JsBuilder::DEFAULT_MAP_ID
    end

    def map_class
      default_class = map_options.try(:[], :provider) == "bing" ? "bing_map" : "gmaps4rails_map"
      map_options.try(:[], :class) || default_class
    end
    
    def container_class
      map_options.try(:[], :container_class) || "map_container"
    end

  end  
  
end