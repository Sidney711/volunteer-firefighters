class RodauthApp < Rodauth::Rails::App
  configure RodauthMain

  route do |r|
    rodauth.load_memory

    r.rodauth

    unless r.path.start_with?("/api")
      rodauth.require_account
    end
  end
end
