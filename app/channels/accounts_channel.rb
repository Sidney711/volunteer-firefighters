class AccountsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "accounts"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
