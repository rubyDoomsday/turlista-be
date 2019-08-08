Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_extension_type => :json,
    :api_file_path => "public/docs/",
    :base_path => Turlista::Config::BASE_PATH,
    :clean_directory => true,
    :camelize_model_properties => false,
    :attributes => {
      :info => {
        "title" => "Turlista",
        "description" => "API for managing travel itineraries for groups",
        "contact" => "creative@rebeccachapin.com",
        "license" => "Creative Commons Attribution-ShareAlike 4.0 International License",
        "licenseUrl" => "https://creativecommons.org/licenses/by-sa/4.0/"
      }
    }
  }
})
