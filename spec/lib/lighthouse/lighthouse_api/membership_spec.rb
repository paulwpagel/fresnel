require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/lighthouse_api/membership"

describe Lighthouse::LighthouseApi::Membership do
  it "should have return all user names for a project" do
    Lighthouse::LighthouseApi::Membership.all_user_names(123)
  end
end
