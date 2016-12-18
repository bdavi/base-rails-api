require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before do
    allow(ENV).to receive(:[]).with("WEB_UI_URL").and_return("http://www.somedomain.com")
    token = double(token: "theTokenHere")
    allow(user).to receive(:access_token).and_return(token)
    allow(Rails.configuration).to receive(:application_display_name).and_return("Some App Name")
  end

  describe '#password_reset_email' do
    let(:user) { create(:user, name: "Jane Doe") }
    let(:mailer) { described_class.password_reset_email(user).deliver_now }

    it "has the expected subject" do
      expect(mailer.subject).to eq("Some App Name Password Reset")
    end

    it "has the expected to email" do
      expect(mailer.to).to eq([user.email])
    end

    it "has the expected from email" do
      expect(mailer.from).to eq([ApplicationMailer.default[:from]])
    end

    it "has the expected body" do
      expected_pieces = [
        "Hello Jane Doe,",
        /www.somedomain.com\/user-profile\/reset-password\?authToken=theTokenHere/,
        "The Some App Name Team"
      ]

      expected_pieces.each do |piece|
        expect(mailer.body.encoded).to match(piece)
      end
    end
  end
end
