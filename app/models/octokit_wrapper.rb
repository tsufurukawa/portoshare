module OctokitWrapper
  class Client
    attr_reader :response, :error_message
    GITHUB_ERROR_MSG = "There was an error trying to access the Github account."

    def initialize(options={}, error_message=nil)
      @response = Octokit::Client.new(access_token: options[:access_token])
      @error_message = error_message
    end

    def repos
      begin
        response.repos(response, sort: :updated_at).first(5)
      rescue Octokit::Unauthorized => e
        @error_message = GITHUB_ERROR_MSG
      end
    end

    # only use this method if the 'repos' method is called beforehand
    # this is because instantiating a new Octokit::Client object will NOT throw an exception
    # even with an invalid access_token - it only does so when trying to access the contained data
    def valid?
      error_message.blank?
    end
  end
end