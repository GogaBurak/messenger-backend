# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    @messages = []
    @messages << { text: 'it works' }
  end
end
