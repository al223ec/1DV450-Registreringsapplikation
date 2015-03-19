require 'spec_helper'
require 'my_spec_helper.rb'

describe Api::V1::EventsController do
  render_views

  describe "index" do
    before do
      populate_test_data
      request.env['HTTP_ACCEPT'] = "application/json"
      request.env['HTTP_AUTHORIZATION'] = "Token token=#{@app.key}"
      xhr :get, :query, format: :json, queries: queries
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_content
      ->(object) { object["content"] }
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

  describe "show" do
      before do
        populate_test_data
        request.env['HTTP_ACCEPT'] = "application/json"
        request.env['HTTP_AUTHORIZATION'] = "Token token=#{@app.key}"
        request.env['HTTP_JWT'] = @end_user.get_jwt

        xhr :get, :show, format: :json, id: event_id
      end

      subject(:results) {  JSON.parse(response.body) }

      context "when the event exists" do
       let(:event_id) { @event.id }
        it { expect(response.status).to eq(200) }
        it { expect(results["id"]).to eq(@event.id) }
        it { expect(results["content"]).to eq(@event.content) }
        it { expect(results["end_user"]["name"]).to eq(@end_user.name) }
      end

      context "when the event doesn't exit" do
        let(:event_id) { -9999 }
        it { expect(response.status).to eq(404) }
      end
    end

    private
      def populate_test_data
        api_user = ApiUser.create!(
          name: "Example User",
          email: "example_rspec@mail.com",
          password: "foobar",
          password_confirmation: "foobar",
          admin: false
        )

        @app = Application.create!(
          name: "Miss Schuyler Padberg",
          api_user: api_user,
          );

        @end_user = EndUser.create!(
          name: "End User",
          email: "end_user_rspec@mail.com",
          password: "foobar",
          password_confirmation: "foobar",
          application_id: @app.id
        )

        position = Position.create!(  lat: 59.08793, lng: 17.96473)
        @event = Event.create!( content: 'Baked Potato w/ Cheese', position: position, end_user: @end_user, application: @app)
        Event.create!(content: 'Garlic Mashed Potatoes', position: position, end_user: @end_user, application: @app)
        Event.create!(content: 'Potatoes Au Gratin', position: position, end_user: @end_user, application: @app)
        Event.create!(content: 'Baked Brussel Sprouts', position: position, end_user: @end_user, application: @app)
      end
end
