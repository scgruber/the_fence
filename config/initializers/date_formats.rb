module ActiveSupport::CoreExtensions
  Time::DATE_FORMATS.update(
    :fence_standard => "%l:%M%p %m/%d/%Y",
    :iso8601 => lambda { |date| date.iso8601 }
  )
end