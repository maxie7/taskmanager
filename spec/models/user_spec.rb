require 'spec_helper'

  describe User do
    let(:valid_attributes) {
	  {
	    first_name: "Max",
	    last_name: "Kosenko",
	    email: "maxie7@protonmail.com",
	    password: "protonmail777",
	    password_confirmation: "protonmail777"
	  }
    }	
    context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
    User.create(valid_attributes)
    end

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "MAX@AMERICA.COM"
      expect(user).to validate_uniqueness_of(:email)
    end
    
    it "requires the email address to look like an email" do
      user.email = "max"
      expect(user).to_not be_valid
    end
  end

  describe "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "MAX@AMERICA.COM"))
      # user.downcase_email
      # expect(user.email).to eq("max@america.com")
      expect{ user.downcase_email }.to change{ user.email }.
        from("MAX@AMERICA.COM").
        to("max@america.com")
    end

    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "MAX@AMERICA.COM"
      expect(user.save).to be_true
      expect(user.email).to eq("max@america.com")
    end
  end
end