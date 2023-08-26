# typed: false
# frozen_string_literal: true

module Openai
  class Embeddings
    def fetch(text:)
      response = HTTP.auth("Bearer #{api_key}")
                   .post(
                     endpoint_uri,
                     json: {
                       input: text,
                       model: model_name,
                     }
                   )

      response.parse.dig('data', 0, 'embedding')
    end

    private

    def endpoint_uri
      "#{Openai::BASE_URI}/v1/embeddings"
    end

    def model_name
      'text-embedding-ada-002'
    end

    def api_key
      ENV.fetch('OPENAI_API_TOKEN')
    end
  end
end
