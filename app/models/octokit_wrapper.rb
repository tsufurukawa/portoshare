module OctokitWrapper
  class Client
    attr_reader :response, :error_message
    GITHUB_ERROR_MSG = "There was an error trying to access the Github account. Please contact customer service if the problem persists."

    def initialize(options={}, error_message=nil)
      @response = Octokit::Client.new(access_token: options[:access_token])
      @error_message = error_message
    end

    def repos
      begin
        response.repos
      rescue Octokit::Unauthorized => e
        @error_message = GITHUB_ERROR_MSG
      end
    end

    def user
      begin
        response.user
      rescue Octokit::Unauthorized => e
        @error_message = GITHUB_ERROR_MSG 
      end
    end

    # only use this method if either the 'repos' or 'user' method is called beforehand
    # this is because instantiating a new Octokit::Client object will NOT throw an exception
    # even with an invalid access_token - it only does so when trying to access the contained data
    def valid?
      error_message.blank?
    end
  end
end