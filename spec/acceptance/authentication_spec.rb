require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource "Authentication", :acceptance do
  describe "retrieving a token" do
    let!(:password) { "J3lksdyy6;0^#"                   }
    let!(:user)     { create(:user, password: password) }
    let!(:username) { user.email                        }

    context "with a valid username and password" do
      post "/oauth/token" do
        let :raw_post do
          {
            grant_type: "password",
            username: username,
            password: password
          }
        end

        example_request "Retreive authentication token" do
          expect(response_status).to eq 200
          token = Doorkeeper::AccessToken.find_by_token(parsed_response[:access_token])
          expect(token.resource_owner_id).to eq user.id
        end
      end
    end

    context "with an invalid password", document: false do
      post "/oauth/token" do
        let :raw_post do
          {
            grant_type: "password",
            username: username,
            password: "incorrect password"
          }
        end

        example_request "returns a 401" do
          expect(response_status).to eq 401
        end
      end
    end

    context "with an invalid username", document: false do
      post "/oauth/token" do
        let :raw_post do
          {
            grant_type: "password",
            username: "not@a-real-user.com",
            password: password
          }
        end

        example_request "returns a 401" do
          expect(response_status).to eq 401
        end
      end
    end
  end

  describe "accessing a protected resource", document: false do
    context "when authenticated" do
      get "v1/users/", :authenticated do
        example_request "returns a 200", document: false do
          expect(response_status).to eq 200
        end
      end
    end

    context "when not authenticated" do
      get "v1/users/" do
        example_request "returns a 401" do
          expect(response_status).to eq 401
        end
      end
    end
  end
end
