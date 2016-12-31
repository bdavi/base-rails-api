JSONAPI.configure do |config|
  config.default_paginator = :offset
  config.default_page_size = 10
  config.maximum_page_size = 20

  config.use_text_errors = true

  config.raise_if_parameters_not_allowed = false

  config.exception_class_whitelist = [Pundit::NotAuthorizedError]

  config.top_level_meta_include_record_count = true
  config.top_level_meta_record_count_key = :record_count
end
