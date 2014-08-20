require 'spec_helper'

describe V1::GamesController do
  render_views

  let(:user) { create(:user) }
  let(:location) { create(:location) }
  let(:game) { create(:game) }
  let(:activity) { create(:activity) }

  describe "POST 'create'" do    
    it "returns http success if parameters are valid" do
      start_time = (Time.zone.now+1.day).to_s
      end_time = (Time.zone.now+1.day+2.hours).to_s
      expect {
        post :create, game: { organizer_id: user.id, title: 'New Game', activity_id: activity.id, location_id: location.id, start_time: start_time, end_time: end_time, size: 10 }, email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ Game.count }.by(1)

      new_game = Game.first
      new_game.organizer_id.should == user.id
      new_game.title.should == 'New Game'
      new_game.location.should == location
      new_game.start_time.should == start_time
      new_game.end_time.should == end_time
      new_game.size.should == 10
    end

    it "assigns location_id if given location" do
      start_time = (Time.zone.now+1.day).to_s
      end_time = (Time.zone.now+1.day+2.hours).to_s
      expect {
        post :create, game: { organizer_id: user.id, title: 'New Game', activity_id: activity.id, location: location.name, start_time: start_time, end_time: end_time, size: 10 }, email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ Game.count }.by(1)

      new_game = Game.first
      new_game.location_id.should == location.id
    end

    it "assign activity_id if given activity" do
      start_time = (Time.zone.now+1.day).to_s
      end_time = (Time.zone.now+1.day+2.hours).to_s
      expect {
        post :create, game: { organizer_id: user.id, title: 'New Game', activity: activity.name, location: location.name, start_time: start_time, end_time: end_time, size: 10 }, email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ Game.count }.by(1)

      new_game = Game.first
      new_game.activity_id.should == activity.id
    end

    it "returns 400 if the parameters are invalid" do
      expect {
        post :create, game: { location_id: location.id, size: 10 }, email: user.email, authentication_token: user.authentication_token
        response.code.should == '400'
      }.to_not change{ Game.count }
    end

  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: game.id, email: user.email, authentication_token: user.authentication_token
      json = JSON.parse(response.body)
      json.should == { id: game.id, title: game.title, size: game.size, experience_level: game.experience_level, min_age: game.min_age, max_age: game.max_age, gender_requirement: game.gender_requirement, drinks_requirement: game.drinks_requirement, competitiveness: game.competitiveness, status: game.status, neighborhood: game.location.neighborhood, organizer_name: game.organizer.name, activity_name: game.activity.name, start_time: game.start_time.to_s, end_time: game.end_time.to_s, attendances: [] }.with_indifferent_access
    end

    it "returns 400 if the id doesnt exist" do
      get :show, id: 0, email: user.email, authentication_token: user.authentication_token
      response.code.should == '400'
    end
  end

  describe "PATCH 'update'" do
    it "returns http success" do
      put :update, id: game.id, game: { status: 'confirmed' }, email: user.email, authentication_token: user.authentication_token
      response.should be_success

      Game.first.status.should == 'confirmed'
    end

    it "returns 400 if the id doesnt exist" do
      put :update, id: 0, game: { status: 'confirmed' }, email: user.email, authentication_token: user.authentication_token
      response.code.should == '400'
    end    
  end

  describe "GET 'upcoming'" do    
    let!(:game) { create(:game) }

    it "returns games that user isnt organizing or going to" do
      get :upcoming, email: user.email, authentication_token: user.authentication_token
      response.should be_success      

      json = JSON.parse(response.body)
      json[0].should == { id: game.id, title: game.title, size: game.size, experience_level: game.experience_level, min_age: game.min_age, max_age: game.max_age, gender_requirement: game.gender_requirement, drinks_requirement: game.drinks_requirement, competitiveness: game.competitiveness, status: game.status, neighborhood: game.location.neighborhood, organizer_name: game.organizer.name, activity_name: game.activity.name, start_time: game.start_time.to_s, end_time: game.end_time.to_s, attendances: [] }.with_indifferent_access
    end
  end

  describe "GET 'going'" do
    let!(:attendance) { create(:attendance) }

    it "returns games that user is going to" do
      get :going, email: attendance.user.email, authentication_token: attendance.user.authentication_token
      response.should be_success
      
      game = attendance.game
      json = JSON.parse(response.body)
      json[0].should == { id: game.id, title: game.title, size: game.size, experience_level: game.experience_level, min_age: game.min_age, max_age: game.max_age, gender_requirement: game.gender_requirement, drinks_requirement: game.drinks_requirement, competitiveness: game.competitiveness, status: game.status, neighborhood: game.location.neighborhood, organizer_name: game.organizer.name, activity_name: game.activity.name, start_time: game.start_time.to_s, end_time: game.end_time.to_s,
        attendances: [
          { id: attendance.id,
            user_id: attendance.user_id,
            game_id: attendance.game_id,
            status: attendance.status}
        ]
      }.with_indifferent_access
    end
  end

  describe "GET 'organizing'" do
    it "returns games that user is organizing" do
      get :organizing, email: game.organizer.email, authentication_token: game.organizer.authentication_token
      response.should be_success

      json = JSON.parse(response.body)
      json[0].should == { id: game.id, title: game.title, size: game.size, experience_level: game.experience_level, min_age: game.min_age, max_age: game.max_age, gender_requirement: game.gender_requirement, drinks_requirement: game.drinks_requirement, competitiveness: game.competitiveness, status: game.status, neighborhood: game.location.neighborhood, organizer_name: game.organizer.name, activity_name: game.activity.name, start_time: game.start_time.to_s, end_time: game.end_time.to_s, attendances: [] }.with_indifferent_access
    end
  end

  describe "DESTROY" do
    it "destroys game that user is organizing" do
      delete :destroy, id: game.id, email: game.organizer.email, authentication_token: game.organizer.authentication_token
      Game.find(game.id).status.should == 'canceled'
      response.should be_success
    end

    it "returns 400 if the user isn't the organizer" do
      delete :destroy, id: game.id, email: user.email, authentication_token: user.authentication_token
      response.code.should == '400'
    end
  end
end
