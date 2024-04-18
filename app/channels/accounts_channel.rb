class AccountsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "accounts"
  end

  def unsubscribed
  end
end