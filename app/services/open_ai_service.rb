class OpenAiService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize
    @api_key = Rails.application.credentials.openai
    @headers = {
      'Authorization': "Bearer #{@api_key}",
      'Content-Type': 'application/json'
    }
  end

  def get_description(prompt, temperature = 0.7)
    body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "user",
          "content": prompt
        }
      ],
      "temperature": temperature
    }

    response = self.class.post('/chat/completions', headers: @headers, body: body.to_json)

    if response.success?
      response['choices'][0]['message']['content']
    else
      raise "Error fetching description: #{response.message}"
    end
  end
end
