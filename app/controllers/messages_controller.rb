class MessagesController < ApplicationController
  def index
    @messages = []
    @messages << { text: 'it works' }
  end
end
