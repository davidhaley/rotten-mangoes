class RemoveImageUrlFromMoviesAddImage < ActiveRecord::Migration[5.0]
  def up
    remove_column :movies, :poster_image_url
    add_column :movies, :image, :string
  end

  def down
    add_column :movies, :poster_image_url
    remove_column :movies, :image, :string
  end
end