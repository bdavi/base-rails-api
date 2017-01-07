RSpec.shared_examples "validate_format_as_email_of" do |attribute|
  it "validates the format of :#{attribute} as an email" do
    subject.send("#{attribute}=", "not an email")
    subject.valid?
    expect(subject.errors[attribute]).to include "invalid email format"

    subject.send("#{attribute}=", "goodemail@address.com")
    subject.valid?
    expect(subject.errors[attribute]).to be_empty
  end
end
