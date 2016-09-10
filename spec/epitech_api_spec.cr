require "./spec_helper"

describe EpitechApi do
  describe ".sign_in" do
    context "with invalid credentials" do
      it "should not set the access token and return nil" do
        tok = EpitechApi.sign_in(login: "fake_f", password: "notarealpass")
        tok.should be_nil
        EpitechApi.access_token.should be_nil
      end
    end

    context "with valid credentials" do
      it "should set and return the access token" do
        tok = EpitechApi.sign_in(login: ENV["EPITECH_LOGIN"], password: ENV["EPITECH_PASSWORD"])
        tok.should be_a String
        EpitechApi.access_token.should_not be_nil
      end
    end
  end
end
