require 'spec_helper'

describe Api::V1::EventsController do
  render_views

  describe "index" do
    before do
      api_user = ApiUser.create!(
        name: "Example User",
        email: "example@mail.com",
        password: "foobar",
        password_confirmation: "foobar",
        admin: false
      )

      app = Application.create!(
        name: "Miss Schuyler Padberg",
        api_user: api_user,
        );
      end_user = EndUser.create!(
        name: "End User",
        email: "end_user@mail.com",
        password: "foobar",
        password_confirmation: "foobar",
        application_id: app.id
      )
      position = Position.create!(  lat: 59.08793, lng: 17.96473)

      Event.create!(content: 'Baked Potato w/ Cheese', position: position, end_user: end_user, application: app)
      Event.create!(content: 'Garlic Mashed Potatoes', position: position, end_user: end_user, application: app)
      Event.create!(content: 'Potatoes Au Gratin', position: position, end_user: end_user, application: app)
      Event.create!(content: 'Baked Brussel Sprouts', position: position, end_user: end_user, application: app)

      request.env['HTTP_ACCEPT'] = "application/json"
      request.env['HTTP_AUTHORIZATION'] = "Token token=#{app.key}"
      xhr :get, :query, format: :json, queries: queries
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_content
      ->(object) { object["event"]["content"] }
    end

    context "when the search finds results" do
      let(:queries) { ['baked'] }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Baked Potato w/ Cheese'" do
        expect(results.map(&extract_content)).to include('Baked Potato w/ Cheese')
      end
      it "should include 'Baked Brussel Sprouts'" do
        expect(results.map(&extract_content)).to include('Baked Brussel Sprouts')
      end
    end

    context "when the search doesn't find results" do
      let(:queries) { ['foo'] }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end
end
