class SnippetsController < ApplicationController

  def index
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(permited_params)
    if @snippet.save
      uri = URI.parse("http://pygments.appspot.com/")
      request = Net::HTTP.post_form(uri, lang: @snippet.language, code: @snippet.plain_code)
      @snippet.update_attribute(:highlighted_code, request.body)
      redirect_to @snippet
    end
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  private
  def permited_params
    params.require(:snippet).permit(:language, :plain_code, :highlighted_code)
  end
end
