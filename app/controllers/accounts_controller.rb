class AccountsController < ApplicationController
  before_action :authenticate
  load_and_authorize_resource
end
