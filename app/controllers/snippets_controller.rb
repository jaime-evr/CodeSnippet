class SnippetsController < ApplicationController

  def index
    @snippet = Snippet.new
    @snippets = Snippet.all
  end

  def create
    @snippet = Snippet.new(permited_params)
    if @snippet.save
      SnippetWorker.perform_async(@snippet.id)
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
