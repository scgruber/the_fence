module ActiveSupport::CoreExtensions
  Time::DATE_FORMATS.update(
    :default => "%l:%M%p %m/%d/%Y"
  )
end