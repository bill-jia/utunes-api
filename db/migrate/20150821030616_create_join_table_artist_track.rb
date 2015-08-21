class CreateJoinTableArtistTrack < ActiveRecord::Migration
  def change
    create_join_table :artists, :tracks do |t|
      # t.index [:artist_id, :track_id]
      # t.index [:track_id, :artist_id]
    end
  end
end
