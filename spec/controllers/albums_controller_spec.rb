require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe AlbumsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Album. As you add validations to Album, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {title: "Potato", year: 2015}
  }

  let(:invalid_attributes) {
    {title: "", year: "Potato"}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AlbumsController. Be sure to keep this updated too.
  let(:valid_session) { {} }


  describe '#index' do
    it 'should return a json array of albums' do
      get :index
      result = JSON.parse(response.body)

      expect(result[0]['title']).to eq("Potato")
    end
  end
  # describe "GET #index" do
  #   it "assigns all albums as @albums" do
  #     album = Album.create! valid_attributes
  #     get :index, {}, valid_session
  #     expect(assigns(:albums)).to eq([album])
  #   end
  # end

  describe "GET #show" do
    before do
      xhr :get, :show, format: :json, id: album_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the album exists" do
      album = Album.create!(title: "Potato", year: 2015)
      let(:album_id) {album.id}
      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(album.id) }
      it { expect(results["title"]).to eq(album.title) }
      it { expect(results["year"]).to eq(album.year) }
    end
  end

  # describe "GET #new" do
  #   it "assigns a new album as @album" do
  #     get :new, {}, valid_session
  #     expect(assigns(:album)).to be_a_new(Album)
  #   end
  # end

  # describe "GET #edit" do
  #   it "assigns the requested album as @album" do
  #     album = Album.create! valid_attributes
  #     get :edit, {:id => album.to_param}, valid_session
  #     expect(assigns(:album)).to eq(album)
  #   end
  # end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Album" do
        expect {
          post :create, {:album => valid_attributes}, valid_session
        }.to change(Album, :count).by(1)
      end

      it "assigns a newly created album as @album" do
        post :create, {:album => valid_attributes}, valid_session
        expect(assigns(:album)).to be_a(Album)
        expect(assigns(:album)).to be_persisted
      end

      it "returns an empty response" do
        post :create, {:album => valid_attributes}, valid_session
        expect(response.status).to eq(204)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: "Rutabaga", year: 2048}
      }

      it "updates the requested album" do
        album = Album.create! valid_attributes
        put :update, {:id => album.to_param, :album => new_attributes}, valid_session
        album.reload
        expect(album.title).to eq("Rutabaga")
        expect(album.year).to eq(2048)
      end

      it "assigns the requested album as @album" do
        album = Album.create! valid_attributes
        put :update, {:id => album.to_param, :album => valid_attributes}, valid_session
        expect(assigns(:album)).to eq(album)
      end

      it "returns an empty response" do
        album = Album.create! valid_attributes
        put :update, {:id => album.to_param, :album => valid_attributes}, valid_session
        expect(response.status).to eq(204)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested album" do
      album = Album.create! valid_attributes
      expect {
        delete :destroy, {:id => album.to_param}, valid_session
      }.to change(Album, :count).by(-1)
    end

    it "returns an empty response" do
      album = Album.create! valid_attributes
      delete :destroy, {:id => album.to_param}, valid_session
      expect(response.status).to eq(204)
    end
  end

end
