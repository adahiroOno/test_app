module API
  class Root < Grape::API
    use GrapeLogging::Middleware::RequestLogger,
        instrumentation_key: 'grape_key',
        include: [
          GrapeLogging::Loggers::FilterParameters.new,
          GrapeLogging::Loggers::ClientEnv.new,
          GrapeLogging::Loggers::RequestHeaders.new
        ]

    mount V1::Resources::Root
  end
end