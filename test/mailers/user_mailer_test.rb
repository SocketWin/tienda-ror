require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "factura_compra" do
    # Create the email and store it for further assertions
    user = User.first
    email = UserMailer.send_compra(user)
    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['ing.ronaldespinoza@gmail.com'], email.from
    assert_equal [user.email], email.to
    assert_equal user.name+', has comprado en La Tienda Virtual', email.subject
  end
end
