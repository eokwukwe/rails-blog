# frozen_string_literal: true

# Migration
class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
    end
  end
end
