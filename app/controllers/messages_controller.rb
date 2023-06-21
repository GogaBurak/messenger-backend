class MessagesController < ApplicationController
  def index
    messages = []
    messages << 'it works'
    render json: { messages: messages }, status: :ok
  end
end
