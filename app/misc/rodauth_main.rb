require "sequel/core"

class RodauthMain < Rodauth::Rails::Auth
  configure do
    enable :create_account, :verify_account, :verify_account_grace_period,
      :login, :logout, :remember,
      :reset_password, :change_password, :change_password_notify,
      :change_login, :verify_login_change, :close_account, :internal_request

    before_login do
      unless account[:is_super_admin] || Membership.where(account_id: account[:id], role: 1).count > 0
        set_field_error(:login, "You do not have permission to log in.")
        flash[:notice] = "You do not have permission to log in."
        throw_error_status(403, :login, "You do not have permission to log in.")
      end
    end

    db Sequel.postgres(extensions: :activerecord_connection, keep_reference: false)

    convert_token_id_to_integer? true
    rails_controller { RodauthController }
    title_instance_variable :@page_title
    account_status_column :status
    account_password_hash_column :password_hash
    verify_account_set_password? true

    login_param "email"
    login_confirm_param "email-confirm"

    delete_account_on_close? true

    already_logged_in do
      if request.path_info == '/login'
        redirect '/'
      end
    end

    create_reset_password_email do
      RodauthMailer.reset_password(self.class.configuration_name, account_id, reset_password_key_value)
    end
    create_verify_account_email do
      RodauthMailer.verify_account(self.class.configuration_name, account_id, verify_account_key_value)
    end
    create_verify_login_change_email do |_login|
      RodauthMailer.verify_login_change(self.class.configuration_name, account_id, verify_login_change_key_value)
    end
    create_password_changed_email do
      RodauthMailer.password_changed(self.class.configuration_name, account_id)
    end

    send_email do |email|
      db.after_commit { email.deliver_later }
    end

    password_minimum_length 8
    password_maximum_bytes 72

    after_login { remember_login }

    extend_remember_deadline? true

    before_create_account do
      unless internal_request?
        account_instance = Account.new(
          full_name: request.params["full_name"],
          birth_date: request.params["birth_date"],
          permament_address: request.params["permament_address"],
          phone: request.params["phone"],
          member_code: request.params["member_code"],
          is_super_admin: false
        )

        unless account_instance.valid?
          account_instance.errors.each do |error|
            set_error_flash "#{error.attribute.capitalize} #{error.message}"
          end
          throw_error_status(422, 'account', 'Account creation failed') if account_instance.errors.any?
        end

        account[:full_name] = request.params["full_name"]
        account[:birth_date] = request.params["birth_date"]
        account[:permament_address] = request.params["permament_address"]
        account[:phone] = request.params["phone"]
        account[:member_code] = request.params["member_code"]
        account[:is_super_admin] = false
      end
    end

    logout_redirect "/"

    verify_account_redirect { logout }
    reset_password_redirect { login_path }
    require_login_redirect { login_path }

    after_create_account do
      super()

      account = Account.find_by(email: request.params["email"])

      ActionCable.server.broadcast('accounts', {
        action: 'create',
        account: account.as_json(include: [:awards, :fire_departments])
      })

      request.redirect '/members'
    end

    verify_account_grace_period 0
  end
end