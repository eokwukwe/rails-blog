class AddSlugToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :slug, :string
    add_column :articles, :read_time, :string
    add_index  :articles, :slug, unique: true
  end
end
