class OpenAiService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize
    @api_key = ENV.fetch('OPENAI_KEY') # Replace with your OpenAI API key
    @headers = {
      'Authorization': "Bearer #{@api_key}",
      'Content-Type': 'application/json'
    }
  end

  def get_description(prompt, temperature = 0.7)
    body = {
      "model": 'gpt-4-1106-preview',
      "messages": [
        {
          "role": 'user',
          "content": prompt
        }
      ],
      "temperature": temperature
    }

    response = self.class.post('/chat/completions', headers: @headers, body: body.to_json)

    raise "Error fetching description: #{response.message}" unless response.success?

    response['choices'][0]['message']['content']
  end
end
