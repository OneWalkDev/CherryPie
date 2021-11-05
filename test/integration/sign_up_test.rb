require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test "入会時はメールアドレスだけで確認でき、有効化画面でパスワードで登録できます。" do
    get new_user_registration_path
    assert_template 'devise/registrations/new'

    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: { email:  "" } }
    end
    assert_template 'devise/registrations/new'

    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email:  "sign_up_test@example.com" } }
    end
    follow_redirect!
    assert_template 'root_pages/index'

    user = User.find_by_email("sign_up_test@example.com")
    assert_not user.confirmed?
    assert_nil controller.current_user


    get user_confirmation_path(confirmation_token: user.confirmation_token)
    assert_template 'devise/confirmations/show'

    patch users_confirm_path, params: {user: {
      password: "",
      password_confirmation: "",
      confirmation_token: user.confirmation_token
    }}
    assert_not user.reload.confirmed?
    assert_template 'devise/confirmations/show'

    patch users_confirm_path, params: {user: {
      password: "password",
      password_confirmation: "password2",
      confirmation_token: user.confirmation_token
    }}
    assert_not user.reload.confirmed?
    assert_template 'devise/confirmations/show'

    patch users_confirm_path, params: {user: {
      password: "password",
      password_confirmation: "password",
      confirmation_token: user.confirmation_token
    }}
    follow_redirect!
    assert user.reload.confirmed?
    assert_template 'root_pages/index'
    assert_equal controller.current_user.email, "sign_up_test@example.com"
  end
end